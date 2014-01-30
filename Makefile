# Kobo Calendar
# -------------
#
# Inspired by http://wiki.mobileread.com/wiki/Kobo_WiFi_Hacking
#
# http://www.scherello.de/?id=265
# ftp://www.jlbec.org/pub/armlinux/people/xscale/mainstone/01-27-2005/README.txt
#
# I wanted to be able to build this from scratch and make it easy to add
# different python libraries, etc.
#
# This project uses a Debian release (Wheezy armel) that is close to what is
# on the Kobo, and is relatively modern (Python 2.7).



# Run on Kobo:
# cd root && PYTHONHOME=/mnt/onboard/root/usr PYTHONPATH=/m
# nt/onboard/root/usr/lib/python2.7 LD_LIBRARY_PATH=/mnt/onboard/root/usr/lib/
# arm-linux-gnueabi:/mnt/onboard/root/lib/arm-linux-gnueabi:/mnt/onboard/root/
# usr/lib/arm-linux-gnueabi/pulseaudio REQUESTS_CA_BUNDLE=/mnt/onboard/root/
# etc/ssl/certs/ca-certificates.crt usr/bin/python2.7 ../test-pygame.py; cd ..

EXTRACT = extract

.PHONY: default all
default : all

all : root.tar.gz

DEBS = downloads/python-requests_0.12.1-1_all.deb \
  $(EXTRACT)/pool/main/p/pygame/python-pygame_1.9.1release+dfsg-8_armel.deb \
  $(EXTRACT)/pool/main/libg/libgdata/gir1.2-gdata-0.0_0.12.0-1_armel.deb \
  $(EXTRACT)/pool/main/libg/libgdata/libgdata-common_0.12.0-1_all.deb \
  $(EXTRACT)/pool/main/libg/libgdata/libgdata13_0.12.0-1_armel.deb \
  $(EXTRACT)/pool/main/p/python-gdata/python-gdata_2.0.17+dfsg-1_all.deb \
  $(EXTRACT)/pool/main/p/python-dateutil/python-dateutil_1.5+dfsg-0.1_all.deb \
  $(EXTRACT)/pool/main/z/zlib/zlib1g_1.2.7.dfsg-13_armel.deb \
  $(EXTRACT)/pool/main/o/openssl/libssl1.0.0_1.0.1e-2_armel.deb \
  $(EXTRACT)/pool/main/n/ncurses/libncurses5_5.9-10_armel.deb \
  $(EXTRACT)/pool/main/n/ncurses/ncurses-base_5.9-10_all.deb \
  $(EXTRACT)/pool/main/n/ncurses/ncurses-bin_5.9-10_armel.deb \
  $(EXTRACT)/pool/main/n/ncurses/ncurses-term_5.9-10_all.deb \
  $(EXTRACT)/pool/main/n/ncurses/libncursesw5_5.9-10_armel.deb \
  $(EXTRACT)/pool/main/d/db/libdb5.1_5.1.29-5_armel.deb \
  $(EXTRACT)/pool/main/libx/libxau/libxau6_1.0.7-1_armel.deb \
  $(EXTRACT)/pool/main/t/tiff/libtiff5_4.0.2-6+deb7u2_armel.deb \
  $(EXTRACT)/pool/main/t/tiff3/libtiff4_3.9.6-11_armel.deb \
  $(EXTRACT)/pool/main/d/directfb/libdirectfb-1.2-9_1.2.10.0-5_armel.deb \
  $(EXTRACT)/pool/main/d/directfb/libdirectfb-extra_1.2.10.0-5_armel.deb \
  $(EXTRACT)/pool/main/libx/libxdmcp/libxdmcp6_1.1.1-1_armel.deb \
  $(EXTRACT)/pool/main/r/readline6/libreadline6_6.2+dfsg-0.1_armel.deb \
  $(EXTRACT)/pool/main/r/readline6/readline-common_6.2+dfsg-0.1_all.deb \
  $(EXTRACT)/pool/main/e/expat/libexpat1_2.1.0-1+deb7u1_armel.deb \
  $(EXTRACT)/pool/main/s/sqlite3/libsqlite3-0_3.7.13-1+deb7u1_armel.deb \
  $(EXTRACT)/pool/main/s/sqlite3/sqlite3_3.7.13-1+deb7u1_armel.deb \
  $(EXTRACT)/pool/main/o/openssl/openssl_1.0.1e-2_armel.deb \
  $(EXTRACT)/pool/main/p/pyopenssl/python-openssl_0.13-2+deb7u1_armel.deb \
  $(EXTRACT)/pool/main/b/bzip2/bzip2_1.0.6-4_armel.deb \
  $(EXTRACT)/pool/main/f/fonts-freefont/fonts-freefont-ttf_20120503-1_all.deb \
  $(EXTRACT)/pool/main/libj/libjpeg6b/libjpeg62_6b1-3_armel.deb \
  $(EXTRACT)/pool/main/libj/libjpeg8/libjpeg8_8d-1_armel.deb \
  $(EXTRACT)/pool/main/libj/libjpeg8/libjpeg-progs_8d-1_armel.deb \
  $(EXTRACT)/pool/main/p/python2.7/libpython2.7_2.7.3-6_armel.deb \
  $(EXTRACT)/pool/main/p/python2.7/python2.7-minimal_2.7.3-6_armel.deb \
  $(EXTRACT)/pool/main/p/python2.7/python2.7_2.7.3-6_armel.deb \
  $(EXTRACT)/pool/main/libs/libsdl1.2/libsdl1.2debian_1.2.15-5_armel.deb \
  $(EXTRACT)/pool/main/s/sdl-image1.2/libsdl-image1.2_1.2.12-2_armel.deb \
  $(EXTRACT)/pool/main/s/sdl-mixer1.2/libsdl-mixer1.2_1.2.12-3_armel.deb \
  $(EXTRACT)/pool/main/s/sdl-net1.2/libsdl-net1.2_1.2.8-2_armel.deb \
  $(EXTRACT)/pool/main/s/sdl-ttf2.0/libsdl-ttf2.0-0_2.0.11-2_armel.deb \
  $(EXTRACT)/pool/main/libp/libpng/libpng12-0_1.2.49-1_armel.deb \
  $(EXTRACT)/pool/main/o/openssl/libcrypto1.0.0-udeb_1.0.1e-2_armel.udeb \
  $(EXTRACT)/pool/main/p/pulseaudio/libpulse0_2.0-6.1_armel.deb \
  $(EXTRACT)/pool/main/a/alsa-lib/libasound2_1.0.25-4_armel.deb \
  $(EXTRACT)/pool/main/libx/libx11/libx11-6_1.5.0-1+deb7u1_armel.deb \
  $(EXTRACT)/pool/main/libx/libx11/libx11-xcb1_1.5.0-1+deb7u1_armel.deb \
  $(EXTRACT)/pool/main/libx/libxext/libxext6_1.3.1-2+deb7u1_armel.deb \
  $(EXTRACT)/pool/main/libc/libcaca/libcaca0_0.99.beta18-1_armel.deb \
  $(EXTRACT)/pool/main/t/tslib/libts-0.0-0_1.0-11_armel.deb \
  $(EXTRACT)/pool/main/libc/libcap2/libcap2_2.22-1.2_armel.deb \
  $(EXTRACT)/pool/main/j/json-c/libjson0_0.10-1.2_armel.deb \
  $(EXTRACT)/pool/main/libx/libxcb/libxcb1_1.8.1-2+deb7u1_armel.deb \
  $(EXTRACT)/pool/main/s/slang2/libslang2_2.2.4-15_armel.deb \
  $(EXTRACT)/pool/main/n/ncurses/libtinfo5_5.9-10_armel.deb \
  $(EXTRACT)/pool/main/libi/libice/libice6_1.0.8-2_armel.deb \
  $(EXTRACT)/pool/main/libs/libsm/libsm6_1.2.1-2_armel.deb \
  $(EXTRACT)/pool/main/libx/libxtst/libxtst6_1.2.1-1+deb7u1_armel.deb \
  $(EXTRACT)/pool/main/t/tcp-wrappers/libwrap0_7.6.q-24_armel.deb \
  $(EXTRACT)/pool/main/libs/libsndfile/libsndfile1_1.0.25-5_armel.deb \
  $(EXTRACT)/pool/main/liba/libasyncns/libasyncns0_0.8-4_armel.deb \
  $(EXTRACT)/pool/main/u/util-linux/libuuid1_2.20.1-5.3_armel.deb \
  $(EXTRACT)/pool/main/libx/libxi/libxi6_1.6.1-1+deb7u1_armel.deb \
  $(EXTRACT)/pool/main/f/flac/libflac8_1.2.1-6_armel.deb \
  $(EXTRACT)/pool/main/libo/libogg/libogg0_1.3.0-4_armel.deb \
  $(EXTRACT)/pool/main/libv/libvorbis/libvorbisenc2_1.3.2-1.3_armel.deb \
  $(EXTRACT)/pool/main/libv/libvorbis/libvorbis0a_1.3.2-1.3_armel.deb \
  $(EXTRACT)/pool/main/s/six/python-six_1.1.0-2_all.deb \
  $(EXTRACT)/pool/main/c/ca-certificates/ca-certificates_20130119_all.deb \
  $(EXTRACT)/pool/main/c/curl/curl_7.26.0-1+wheezy6_armel.deb \
  $(EXTRACT)/pool/main/c/curl/libcurl3-gnutls_7.26.0-1+wheezy6_armel.deb \
  $(EXTRACT)/pool/main/c/curl/libcurl3_7.26.0-1+wheezy6_armel.deb \
  $(EXTRACT)/pool/main/c/curl/libcurl4-openssl-dev_7.26.0-1+wheezy6_armel.deb \
  $(EXTRACT)/pool/main/p/pycurl/python-pycurl_7.19.0-5_armel.deb \
  $(EXTRACT)/pool/main/p/python-httplib2/python-httplib2_0.7.4-2+deb7u1_all.deb

.PHONY : debs
debs : $(DEBS)

# The following dependencies are reported by ldd but don't seem to have any
# negative effect if they're removed:
#
# $(EXTRACT)/pool/main/o/openssl-blacklist/openssl-blacklist_0.5-3_all.deb \
# $(EXTRACT)/pool/main/a/attr/libattr1_2.4.46-8_armel.deb \
# $(EXTRACT)/pool/main/b/bzip2/libbz2-1.0_1.0.6-4_armel.deb \
# $(EXTRACT)/pool/main/d/dbus/libdbus-1-3_1.6.8-1+deb7u1_armel.deb \
# $(EXTRACT)/pool/main/f/freetype/libfreetype6_2.4.9-1.1_armel.deb \
# $(EXTRACT)/pool/main/g/glib2.0/libglib2.0-0_2.33.12+really2.32.4-5_armel.deb \
# $(EXTRACT)/pool/main/g/glib2.0/libglib2.0-bin_2.33.12+really2.32.4-5_armel.deb \
# $(EXTRACT)/pool/main/g/glib2.0/libglib2.0-data_2.33.12+really2.32.4-5_all.deb \
# $(EXTRACT)/pool/main/libx/libxml2/libxml2-utils_2.8.0+dfsg1-7+nmu2_armel.deb \
# $(EXTRACT)/pool/main/libx/libxml2/libxml2_2.8.0+dfsg1-7+nmu2_armel.deb \
# $(EXTRACT)/pool/main/libx/libxml2/python-libxml2_2.8.0+dfsg1-7+nmu2_armel.deb \
# $(EXTRACT)/pool/main/libs/libsoup2.4/libsoup2.4-1_2.38.1-2_armel.deb \
# $(EXTRACT)/pool/main/libs/libsoup2.4/libsoup-gnome2.4-1_2.38.1-2_armel.deb \
# $(EXTRACT)/pool/main/libs/libssh/libssh-4_0.5.4-1_armel.deb \
# $(EXTRACT)/pool/main/libs/libssh2/libssh2-1_1.4.2-1.1_armel.deb \
# $(EXTRACT)/pool/main/e/elfutils/libelf1_0.152-1+wheezy1_armel.deb \
# $(EXTRACT)/pool/main/libe/libelf/libelfg0_0.8.13-3_armel.deb \
# $(EXTRACT)/pool/main/libf/libffi/libffi5_3.0.10-3_armel.deb \
# $(EXTRACT)/pool/main/libg/libgcrypt11/libgcrypt11_1.5.0-5+deb7u1_armel.deb \
# $(EXTRACT)/pool/main/x/xz-utils/liblzma5_5.1.1alpha+20120614-2_armel.deb \
# $(EXTRACT)/pool/main/libo/liboauth/liboauth0_0.9.4-3.1_armel.deb \
# $(EXTRACT)/pool/main/p/pcre3/libpcre3_8.30-5_armel.deb \
# $(EXTRACT)/pool/main/p/portmidi/libportmidi0_184-2.1_armel.deb \
# $(EXTRACT)/pool/main/r/rtmpdump/librtmp0_2.4+20111222.git4e06e21-1_armel.deb \
# $(EXTRACT)/pool/main/libv/libvorbis/libvorbisfile3_1.3.2-1.3_armel.deb \
# $(EXTRACT)/pool/main/libw/libwebp/libwebp2_0.1.3-3+nmu1_armel.deb \
# $(EXTRACT)/pool/main/libm/libmad/libmad0_0.15.1b-7_armel.deb \
# $(EXTRACT)/pool/main/libm/libmikmod/libmikmod2_3.1.12-5_armel.deb \
# $(EXTRACT)/pool/main/s/smpeg/libsmpeg0_0.4.5+cvs20030824-5_armel.deb \
# $(EXTRACT)/pool/main/n/nss/libnss3-1d_3.14.5-1_armel.deb \
# $(EXTRACT)/pool/main/n/nss/libnss3_3.14.5-1_armel.deb \
# $(EXTRACT)/pool/main/libg/libgnome-keyring/libgnome-keyring-common_3.4.1-1_all.deb \
# $(EXTRACT)/pool/main/libg/libgnome-keyring/libgnome-keyring0_3.4.1-1_armel.deb \
# $(EXTRACT)/pool/main/libs/libselinux/libselinux1_2.1.9-5_armel.deb \
# $(EXTRACT)/pool/main/n/nspr/libnspr4-0d_4.9.2-1_armel.deb \
# $(EXTRACT)/pool/main/n/nspr/libnspr4_4.9.2-1_armel.deb \
# $(EXTRACT)/pool/main/o/openldap/libldap-2.4-2_2.4.31-1+nmu2_armel.deb \
# $(EXTRACT)/pool/main/j/jbig2dec/libjbig2dec0_0.11+20120125-1_armel.deb \
# $(EXTRACT)/pool/main/j/jbigkit/libjbig0_2.0-2_armel.deb \
# $(EXTRACT)/pool/main/libi/libidn/libidn11_1.25-2_armel.deb \
# $(EXTRACT)/pool/main/h/heimdal/libgssapi3-heimdal_1.6~git20120403+dfsg1-2_armel.deb \
# $(EXTRACT)/pool/main/k/krb5/libgssapi-krb5-2_1.10.1+dfsg-5+deb7u1_armel.deb \
# $(EXTRACT)/pool/main/libg/libgpg-error/libgpg-error0_1.10-3.1_armel.deb \
# $(EXTRACT)/pool/main/g/gnutls26/libgnutls-openssl27_2.12.20-7_armel.deb \
# $(EXTRACT)/pool/main/g/gnutls26/libgnutls26_2.12.20-7_armel.deb \
# $(EXTRACT)/pool/main/g/gnutls26/libgnutlsxx27_2.12.20-7_armel.deb

########################################################################
# Downloaded items:
########################################################################

FORCAST_SHA = d06ecd832c4490a5b19e7f3f5ae796eac33c1077

.PHONY: forcast
forcast : downloads/python-forcast.io-$(FORCAST_SHA)

# python-forcast.io requires a modern python-requests package that is not
# available. It needs a slight patch to fix use the old method of
# accessing the json data structure
downloads/python-forcast.io-$(FORCAST_SHA) : downloads/$(FORCAST_SHA).zip \
					     py-requests-backport.patch
	cd downloads && unzip -o $(FORCAST_SHA).zip
	cd downloads && patch -p0 < ../py-requests-backport.patch

downloads/$(FORCAST_SHA).zip :
	mkdir -p downloads
	wget https://github.com/ZeevG/python-forcast.io/archive/$(FORCAST_SHA).zip -O $@

downloads/rfc3339.py :
	mkdir -p downloads
	wget https://bitbucket.org/henry/rfc3339/raw/2576d7e29c161b4fad412f8b3785862d68c4b7b8/rfc3339.py -O $@

downloads/debian-7.3.0-armel-DVD-1.iso :
	mkdir -p downloads
	wget http://cdimage.debian.org/debian-cd/7.3.0/armel/iso-dvd/debian-7.3.0-armel-DVD-1.iso -O $@
	chattr +i $@

downloads/meteocons.ttf :
	mkdir -p downloads
	wget https://github.com/fontello/meteocons.font/blob/master/font/meteocons.ttf?raw=true -O $@

downloads/python-requests_0.12.1-1_all.deb:
	mkdir -p downloads
	wget http://ftp.us.debian.org/debian/pool/main/r/requests/python-requests_0.12.1-1_all.deb -O $@

$(EXTRACT)/%deb : downloads/debian-7.3.0-armel-DVD-1.iso
	mkdir -p $(@D)
	isoinfo -i $< -RJ -x $(subst $(EXTRACT),,$@) > $@

################################################################################

.extracted : $(DEBS) \
	     downloads/python-forcast.io-$(FORCAST_SHA) \
	     downloads/debian-7.3.0-armel-DVD-1.iso \
	     downloads/python-requests_0.12.1-1_all.deb \
	     downloads/rfc3339.py \
	     downloads/meteocons.ttf
	mkdir -p root
	# .debs can contain a variety of archives, try gz, bz2, xz:
	@ cd root && $(foreach var,$(DEBS),\
		   (ar p ../$(var) data.tar.gz | tar zx) &> /dev/null \
		|| (ar p ../$(var) data.tar.xz | tar Jx) &> /dev/null \
		|| (ar p ../$(var) data.tar.bz2 | tar jx) &> /dev/null;)

	# Generate SSL certificates needed by Python SSL modules
	rm -f root/usr/lib/ssl/certs
	mkdir -p root/etc/ssl/certs
	find -L root/usr/share/ca-certificates -type f -name '*.crt' | \
		while read crt; do cat "$$crt" >> \
		root/etc/ssl/certs/ca-certificates.crt; done

	# Clean up unneeded files
	rm -rf root/usr/include
	rm -rf root/usr/lib/python2.[56] root/usr/lib/pyshared/python2.6
	rm -f root/usr/lib/python2.7/sitecustomize.py
	rm -f root/usr/lib/ssl/private root/usr/lib/ssl/openssl.cnf
	rm -rf root/usr/share/{terminfo,man,doc}
	rm -rf root/usr/share/locale

	# The filesystem this will be extracted to is vfat, so symlinks aren't
	# allowed. Dereference and copy them to where they're expected to be.
	find root -type l -exec cp -L --recursive '{}' '{}'.dereferenced \;
	find root -name \*dereferenced -exec rename .dereferenced "" {} \;
	rm -rf root/usr/share/pyshared

	# Add the extra packages
	mkdir -p root/usr/lib/python2.7/dist-packages
	cp downloads/rfc3339.py root/usr/lib/python2.7/dist-packages/
	cp downloads/meteocons.ttf root/
	cp -R downloads/python-forcast.io-$(FORCAST_SHA)/forecastio \
		root/usr/lib/python2.7/dist-packages/

	touch $@

root.tar.gz : .extracted
	tar czf $@ root

.PHONY: upload
upload : root.tar.gz
	curl -T root.tar.gz ftp://192.168.0.24/mnt/onboard/ \
		--user anonymous:anonymous

upload-script :
	curl -T test-pygame.py ftp://192.168.0.24/mnt/onboard/ \
		--user anonymous:anonymous

.PHONY: clean
clean :
	rm -rf extract
	rm -rf root
	rm -rf dep-tree
	rm -f .extracted
	rm -f root.tar.gz
	rm -f ld-result.txt ld-result-filtered.txt
	rm -f ld-result-filtered-notfound.txt

clean-downloads :
	rm -rf downloads/python-forcast.io-$(FORCAST_SHA)
	rm -f downloads/$(FORCAST_SHA).zip
	rm -f downloads/rfc3339.py
	rm -f downloads/meteocons.ttf
	rm -f downloads/python-requests_0.12.1-1_all.deb

# A slightly hacky way of finding library dependencies as crosstool's ldd
# doesn't allow additional dirs to be specified, move the files to where
# it expects them to be

ld-result.txt : $(DEBS)
	mkdir -p dep-tree
	@ cd dep-tree && $(foreach var,$(DEBS),echo $(var); \
		   (ar p ../$(var) data.tar.gz | tar zx) \
		|| (ar p ../$(var) data.tar.xz | tar Jx) \
		|| (ar p ../$(var) data.tar.bz2 | tar jx);)
	mv dep-tree/lib/arm-linux-gnueabi/* dep-tree/lib/
	mv dep-tree/usr/lib/arm-linux-gnueabi/lib* dep-tree/usr/lib/
	find dep-tree -type f | grep -v py$$ \
	 | grep -v terminfo \
	 | xargs -L 1 \
	 ~/x-tools/arm-unknown-linux-gnueabi/bin/arm-unknown-linux-gnueabi-ldd \
	 --root dep-tree &> ld-result.txt

ld-result-filtered.txt : ld-result.txt
	grep -v ^readelf ld-result.txt > ld-result-filtered.txt

ld-result-filtered-notfound.txt : ld-result-filtered.txt
	grep "not found" ld-result-filtered.txt \
		| sort \
		| uniq > ld-result-filtered-notfound.txt

