#!/usr/bin/python
# -*- coding: utf-8 -*-

import platform
import ConfigParser

import pygame
import array
import os
try:
    from xml.etree import ElementTree
except ImportError:
    from elementtree import ElementTree

import gdata.calendar.data
import gdata.calendar.client
import gdata.acl.data
import atom
import getopt
import sys
import string
import time
import datetime
import dateutil.parser
from rfc3339 import rfc3339

sys.path.append('./python-forcast.io/')
sys.path.append('./python-forcast.io-d06ecd832c4490a5b19e7f3f5ae796eac33c1077')

import forecastio

# TODO:
#
# * Dynamically read screen size and adjust
# * Intelligently schedule the next time to wake up
# * List today's holiday in the today pane
# * Add a 'sleeps' countdown to holidays
# * Add icons for events like soccer practice
# * Phase of the moon icon
# * Add shading to weather icon
# * Show next day's sunrise/set if this one has already passed

class DateSurface():
    def __init__( self, main_surface, origin, size, text_colour ):
        self.main_surface = main_surface
        self.origin = origin
        self.width, self.height = size
        self.font = pygame.font.SysFont("Monospace",
                                        int((self.height / 2) * 0.9),
                                        bold=False)
        self.text_colour = text_colour

    def render( self, cur_time ):
        """Blits to the main PyGame surface"""
        date_str = cur_time.strftime("%A, %B %d, %Y")
        time_str = cur_time.strftime("%I:%M %p")
        if time_str[0] == "0":
            time_str = time_str[1:len(time_str)]
        pad = (len(date_str) - len(time_str))/2
        date_surface = self.font.render(date_str, True, self.text_colour)
        time_surface = self.font.render(time_str, True, self.text_colour)
        date_x = self.origin[0] + (self.width - date_surface.get_size()[0]) / 2
        date_y = self.origin[1] + int((self.height / 2) * 0.1)
        time_x = self.origin[0] + (self.width - time_surface.get_size()[0]) / 2
        time_y = self.origin[1] + int((self.height / 2) * 0.1) \
                + self.font.get_linesize()
        self.main_surface.blit(date_surface, (date_x, date_y))
        self.main_surface.blit(time_surface, (time_x, time_y))

class CalendarSurface():
    def __init__( self, 
                  main_surface, 
                  origin, 
                  size, 
                  text_colour, 
                  email, 
                  password ):
        self.main_surface = main_surface
        self.origin = origin
        self.width, self.height = size
        self.font = pygame.font.SysFont("Monospace", 32, bold=True)
        self.text_colour = text_colour

        self.cal_client = gdata.calendar.client.CalendarClient(source='kobo-cal')
        self.cal_client.ClientLogin(email, password, self.cal_client.source)

        self.last_update = datetime.datetime.min

        # Events is an array of tuples: (name, start_time, end_time)
        self.events = None
        # Holidays is an array of tuples: (name, start_day)
        self.holidays = None

    def render(self, cur_time):
        if cur_time > (self.last_update + datetime.timedelta(minutes=30)):
            self.last_update = cur_time
            self.events, self.holidays = self.getCalendarData(cur_time)
        self.renderEvents()

    def renderEvents(self):
        today_static_surface = self.font.render("Today:",
                                                True,
                                                self.text_colour)
        tomorrow_static_surface = self.font.render("Tomorrow:",
                                                   True,
                                                   self.text_colour)
        holidays_static_surface = self.font.render("Next Holidays:",
                                                   True,
                                                   self.text_colour)
        x = self.origin[0] + 10
        y = self.origin[1] + 10

        self.main_surface.blit(today_static_surface, (x,y))
        y += int(today_static_surface.get_size()[1] * 1.1)

        end_of_day = datetime.date.today() + datetime.timedelta(days=1)
        num_today = 0
        for e in self.events:
            if e[1].date() < end_of_day:
                event_surface = self.font.render(e[0], True, self.text_colour)
                self.main_surface.blit(event_surface, (x+10,y))
                y += int(event_surface.get_size()[1] * 1.1)
                num_today += 1
            else:
                break

        if not num_today:
            event_surface = self.font.render("Nothing scheduled",
                                             True,
                                             self.text_colour)
            self.main_surface.blit(event_surface, (x+10,y))
            y += int(event_surface.get_size()[1] * 1.1)

        y += 10

        self.main_surface.blit(tomorrow_static_surface, (x,y))
        y += int(tomorrow_static_surface.get_size()[1] * 1.1)
        for e in self.events:
            if e[1].date() >= end_of_day:
                event_surface = self.font.render(e[0], True, self.text_colour)
                self.main_surface.blit(event_surface, (x+10,y))
                y += int(event_surface.get_size()[1] * 1.1)
        y += 10

        self.main_surface.blit(holidays_static_surface, (x,y))
        y += int(holidays_static_surface.get_size()[1] * 1.1)
        for e in self.holidays:
            event_surface = self.font.render(e[0], True, self.text_colour)
            self.main_surface.blit(event_surface, (x+10,y))
            y += int(event_surface.get_size()[1] * 1.1)

    def getCalendarData(self, cur_time):
        start_of_day = datetime.date.today()
        end_of_day = datetime.date.today() + datetime.timedelta(days=1)

        # Today's events:
        events = []

        start_date = rfc3339(cur_time)
        end_date = rfc3339(end_of_day + datetime.timedelta(days=1))

        try:
            query = gdata.calendar.client.CalendarEventQuery(start_min=start_date,
                                                        start_max=end_date,
                                                        ctz="America/Vancouver",
                                                        orderby="starttime",
                                                        sortorder="ascending",
                                                        singleevents="true")
            feed = self.cal_client.GetCalendarEventFeed(q=query)

            for an_event in feed.entry:
                start = dateutil.parser.parse(an_event.when[0].start)
                end = dateutil.parser.parse(an_event.when[0].end)
                events.append((an_event.title.text, start, end))
        except:
            pass

        # Next Holidays
        holidays = []

        hol_uri = "https://www.google.com/calendar/feeds/en.canadian%23holiday%40group.v.calendar.google.com/private/full"
        start_date = rfc3339(start_of_day)
        try:
            query = gdata.calendar.client.CalendarEventQuery(
                                                        start_min=start_date,
                                                        ctz="America/Vancouver",
                                                        orderby="starttime",
                                                        singleevents="true",
                                                        sortorder="ascending",
                                                        max_results=4)
            feed = self.cal_client.GetCalendarEventFeed(q=query, uri=hol_uri)

            for an_event in feed.entry:
                start = dateutil.parser.parse(an_event.when[0].start)
                holidays.append((an_event.title.text, start.date()))
        except:
            pass

        return (events,holidays)


class WeatherSurface():
    def __init__( self, main_surface, origin, size, text_colour, api_key ):
        self.main_surface = main_surface
        self.origin = origin
        self.width, self.height = size
        self.font = pygame.font.SysFont("Monospace", 32, bold=True)
        self.text_colour = text_colour

        self.API_KEY = api_key
        self.LAT = 49.2625
        self.LON = -122.7811

        # There is a limit to how many calls can be made to the forecast.io API.
        # Track the last update so we don't exceed the limit
        self.last_update = datetime.datetime.min
    
        # Create a font for rendering weather icons
        self.weather_font = pygame.font.Font("meteocons.ttf", 100)

        # Possible icon text from forecast.io:
        #   clear-day 
        #   clear-night 
        #   rain 
        #   snow 
        #   sleet 
        #   wind 
        #   fog 
        #   cloudy 
        #   partly-cloudy-day 
        #   partly-cloudy-night
        #
        
        self.font_lookup = {
           'clear-day' : 'B',
           'clear-night' : 'C',
           'rain' : 'R',
           'snow' : 'W',
           'sleet' : 'X',
           'wind' : 'F',
           'fog' : 'L',
           'cloudy' : 'Y',
           'partly-cloudy-day' : 'H',
           'partly-cloudy-night' : 'I'
           }

        self.forecast = None

    def render(self, cur_time):
        if cur_time > self.last_update + datetime.timedelta(minutes=30):
            # Check for new forecast
            self.forecast = forecastio.load_forecast(self.API_KEY,
                                                     self.LAT,
                                                     self.LON)
            self.last_update = cur_time

        self.renderForecast()

    def renderForecast( self ):
        # Frame should render:
        #
        # Current Temp:
        #    15 °C
        #
        # High: 20 °C
        # Low:   9 °C
        #
        # Forecast:
        #
        #  * ICON *
        #
        # Chance of rain:
        #    50 %
        #
        # Sunrise:
        #  6:00 am
        #
        # Sunset:
        #  7:00 pm
        #

        if self.forecast:
            cur_temp_static_surface = self.font.render("Current Temp:",
                                                       True,
                                                       self.text_colour)
            cur_temp_data_surface = self.font.render(u"%d °C" % self.forecast.currently().temperature,
                                                       True,
                                                       self.text_colour)
            high_temp_data_surface = self.font.render(u"High: %d °C" % self.forecast.daily().data[0].temperatureMax,
                                                       True,
                                                       self.text_colour)
            low_temp_data_surface = self.font.render(u"Low: %d °C" % self.forecast.daily().data[0].temperatureMin,
                                                       True,
                                                       self.text_colour)
            forecast_static_surface = self.font.render("Forecast:",
                                                       True,
                                                       self.text_colour)

            if self.forecast.daily().data[0].icon in self.font_lookup:
                weather_char = self.font_lookup[self.forecast.daily().data[0].icon]
            else:
                weather_char = 'B'

            weather_surface = self.weather_font.render(weather_char, True, self.text_colour)
            weather_surface2 = self.weather_font.render(weather_char, True, tuple( x + 80 for x in self.text_colour))

            precip_static_surface = self.font.render("Chance of Rain:",
                                                       True,
                                                       self.text_colour)
            precip_data_surface = self.font.render("%s%%" % int(self.forecast.daily().data[0].precipProbability * 100),
                                                       True,
                                                       self.text_colour)

            sunrise_static_surface = self.font.render("Sunrise:",
                                                       True,
                                                       self.text_colour)
            sunrise_string = self.forecast.daily().data[0].sunriseTime.strftime("%I:%M %p")
            if sunrise_string[0] == "0":
                sunrise_string = sunrise_string[1:len(sunrise_string)]
            sunrise_data_surface = self.font.render("%s" % sunrise_string,
                                                       True,
                                                       self.text_colour)

            sunset_static_surface = self.font.render("Sunset:",
                                                       True,
                                                       self.text_colour)
            sunset_string = self.forecast.daily().data[0].sunsetTime.strftime("%I:%M %p")
            if sunset_string[0] == "0":
                sunset_string = sunset_string[1:len(sunset_string)]
            sunset_data_surface = self.font.render("%s" % sunset_string,
                                                       True,
                                                       self.text_colour)

            x = self.origin[0] + 10
            y = self.origin[1] + 10

            center = self.origin[0] + (self.width / 2)

            self.main_surface.blit(cur_temp_static_surface, (x,y))
            y += int(cur_temp_static_surface.get_size()[1] * 1.1)

            centered_x = center - cur_temp_data_surface.get_size()[0]/2
            self.main_surface.blit(cur_temp_data_surface, (centered_x,y))
            y += int(cur_temp_data_surface.get_size()[1] * 1.1)
            y += 10

            self.main_surface.blit(high_temp_data_surface, (x,y))
            y += int(high_temp_data_surface.get_size()[1] * 1.1)

            self.main_surface.blit(low_temp_data_surface, (x,y))
            y += int(low_temp_data_surface.get_size()[1] * 1.1)
            y += 10

            self.main_surface.blit(forecast_static_surface, (x,y))
            y += int(forecast_static_surface.get_size()[1] * 1.1)
            y += 10

            centered_x = center - weather_surface.get_size()[0]/2
            self.main_surface.blit(weather_surface2, (centered_x + 3, y + 3))
            self.main_surface.blit(weather_surface, (centered_x,y))
            y += int(weather_surface.get_size()[1] * 1.1)
            y += 10

            self.main_surface.blit(precip_static_surface, (x,y))
            y += int(precip_static_surface.get_size()[1] * 1.1)

            centered_x = center - precip_data_surface.get_size()[0]/2
            self.main_surface.blit(precip_data_surface, (centered_x,y))
            y += int(precip_data_surface.get_size()[1] * 1.1)
            y += 10

            self.main_surface.blit(sunrise_static_surface, (x,y))
            y += int(sunrise_static_surface.get_size()[1] * 1.1)

            centered_x = center - sunrise_data_surface.get_size()[0]/2
            self.main_surface.blit(sunrise_data_surface, (centered_x,y))
            y += int(sunrise_data_surface.get_size()[1] * 1.1)

            self.main_surface.blit(sunset_static_surface, (x,y))
            y += int(sunset_static_surface.get_size()[1] * 1.1)

            centered_x = center - sunset_data_surface.get_size()[0]/2
            self.main_surface.blit(sunset_data_surface, (centered_x,y))


def main():

    # Behaviour changes depending on which platform we are on
    on_kobo = (platform.machine() == 'armv5tejl')
    filename = '/tmp/x.pgm'

    if on_kobo:
        os.system('/usr/local/Kobo/pickel blinkoff')
        os.system('killall nickel')

    # Parse config file to pass items on to submodules
    config = ConfigParser.ConfigParser()
    CFG_FILE = '../.kobocal'
    if config.read(CFG_FILE)[0] != CFG_FILE:
        print "Error reading config file"
        sys.exit(-1)

    email = config.get('main', 'email')
    password = config.get('main', 'password')
    forecast_key = config.get('main', 'forecast-key')

    if email == -1 or password == -1 or forecast_key == -1:
        print "Error reading config file"
        sys.exit(-1)

    # Kobo WiFi dimensions
    width = 600
    height = 800

    # Set up some defaults and layout the screen

    line_width = line_height = 3
    line_colour = (190,190,190)

    background_colour = (255, 255, 255)

    text_colour = (63,63,63)

    date_header_height = 80
    date_header_origin = (0,0)
    date_header_width = width

    calendar_height = weather_height = height - date_header_height - line_width
    calendar_width = width * 0.66
    calendar_origin = (0, (date_header_height + line_height))

    weather_width = width - calendar_width - line_width
    weather_height = height - date_header_height - line_width
    weather_origin = ((calendar_width + line_width),
                     (date_header_height + line_height))


    # Create the pygame surfaces, they will be rendered to main_surface
    # and set to the framebuffer or kobo screen.
    pygame.init()
    if on_kobo:
        main_surface = pygame.Surface((width,height))
    else:
        main_surface = pygame.display.set_mode((width, height))

    date_surface = DateSurface(main_surface,
                               date_header_origin,
                               (date_header_width,date_header_height),
                               text_colour)

    weather_surface = WeatherSurface(main_surface,
                                     weather_origin,
                                     (weather_width, weather_height),
                                     text_colour,
                                     forecast_key)

    calendar_surface = CalendarSurface(main_surface,
                                       calendar_origin,
                                       (calendar_width, calendar_height),
                                       text_colour,
                                       email, password)

    while True:
        buff=array.array('B')

        # Completely redraw the surface, starting with background
        main_surface.fill(background_colour)

        # Add the borders
        pygame.draw.line(main_surface, 
                         line_colour,
                         (0, date_header_height),
                         (width, date_header_height),
                         line_width)
        pygame.draw.line(main_surface, 
                         line_colour,
                         (calendar_width, date_header_height),
                         (calendar_width, height),
                         line_width)

        # Render the frames according to the current time
        t = datetime.datetime.now()

        date_surface.render(t)
        weather_surface.render(t)
        calendar_surface.render(t)

        # Depending on where it is running, output the image

        if on_kobo:
            for row in range(main_surface.get_height()):
                for col in range(main_surface.get_width()):
                    buff.append(main_surface.get_at((col, row))[0])

            try:
                fout=open(filename, 'wb')
            except IOError, er:
                print "Cannot open file ", filename, "Exiting ... \n", er
                sys.exit()

            buff.tofile(fout)
            fout.close()

            os.system('cat %s | /usr/local/Kobo/pickel showpic' % filename)

            if False:
                os.system('killall wpa_supplicant')
                os.system('wlarm_le -i eth0 down')
                os.system('ifconfig eth0 down')
                print "Going to sleep"
                os.system('echo 30 > /sys/power/sleeptime')
                os.system('echo "mem" > /sys/power/state')
                os.system('rmmod dhd')
                os.system('rmmod sdio_wifi_pwr')
                os.system('insmod /drivers/m166e/wifi/dhd.ko')
                os.system('insmod /drivers/m166e/wifi/sdio_wifi_pwr.ko')
                os.system('/usr/local/Kobo/pickel wifion')
                os.system('/usr/local/Kobo/pickel wifion')
                time.sleep(1)
                os.system('wlarm_le -i eth0 up')
                os.system('ifconfig eth0 up')
                os.system('wpa_supplicant -s -i eth0 -c /etc/wpa_supplicant/wpa_supplicant.conf -C /var/run/wpa_supplicant -B')
                time.sleep(2)
                os.system('udhcpc -S -i eth0 -s /etc/udhcpc.d/default.script -t15 -T3 -A1 -f -q')
                os.system('ntpd -q -p pool.ntp.org -S /usr/local/Kobo/ntpd.sh')
                time.sleep(30)
                print "Awake"
            else:
                break
        else:
            pygame.display.flip()
            time.sleep(5)
            ev = pygame.event.poll()
            if ev.type == pygame.QUIT:   # Window close button clicked?
                break                    # Leave game loop

    pygame.quit()


main()
