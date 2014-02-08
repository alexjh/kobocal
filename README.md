# Kobo Family Calendar #

I was inspired by the [Kobo Weather Station](http://www.mobileread.com/forums/showthread.php?t=194376)
I saw on hackaday to build something with my Kobo Wifi. I picked up a broken
Kobo on Craigslist for experimentation as I was worried about bricking it.

This project serves two purposes:

* learning about the Google Data API.
* teaching my kids about the weather and planning their day accordingly.

## Usage ##

I set up the Kobo to execute /mnt/sd/run.sh if it exists. This way I can insert
the SD card with the project on it if it is to run in Calendar mode, and if I
want to run it in eReader mode, I simply remove the SD card.

You can also run it on the host for faster testing.

## Implementation ##

I took a shortcut to getting Python up and running by using the Debian Wheezy
armel port. I thought I was rather clever until I discovered on the MobileRead
forums that someone else had already come up with this in 2012.

## Configuration ##

A config file called '.kobocal' is needed:

  [main]
  email = example@example.com
  password = secret
  forecast-key = abcd1234
  latitude = 0.0
  longitude = 0.0

* Email and password are the Google account to use.
* forecast-key is an API key from [forecast.io](https://developer.forecast.io/register)

## Installation ##

Note that this has only been tested on a Kobo WiFi. Other models may need some
different steps taken.

* Build the default target of the Makefile. This will result in root.tar.gz
  being created.
* [Enable telnet](http://wiki.mobileread.com/wiki/Kobo_WiFi_Hacking#Enabling_Telnet_.26_FTP)
  on the Kobo
* Power off the Kobo
* Insert an SD card
* Turn the Kobo on and choose 'Manage Library'
* Copy root.tar.gz, .kobocal, kobocal.py, and run.sh to the SD card when it
  mounts. Do not copy this to the 'KOBOReader' device. It should appear as
  something else related to your SD card.
* Telnet into the Kobo
* Edit /etc/init.d/rcS2 to execute /mnt/sd/run.sh:
  echo /mnt/sd/run.sh >> /etc/init.d/rcS2
* Extact the supporting files:
  cd /mnt/sd && tar xf root.tar.gz
* Reboot the Kobo via telnet or power off/on again via the power button.
