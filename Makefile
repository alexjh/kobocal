# Run on Kobo:
# cd root && PYTHONHOME=/mnt/onboard/root/usr PYTHONPATH=/m
# nt/onboard/root/usr/lib/python2.7 LD_LIBRARY_PATH=/mnt/onboard/root/usr/lib/arm-
# linux-gnueabi:/mnt/onboard/root/lib/arm-linux-gnueabi:/mnt/onboard/root/usr/lib/
# arm-linux-gnueabi/pulseaudio REQUESTS_CA_BUNDLE=/mnt/onboard/root/etc/ssl/certs/
# ca-certificates.crt usr/bin/python2.7 ../test-pygame.py; cd ..

.PHONY: default all
default : all

all : .extracted

DEBS = mnt2/pool/main/p/pygame/python-pygame_1.9.1release+dfsg-8_armel.deb \
       mnt2/pool/main/libg/libgdata/gir1.2-gdata-0.0_0.12.0-1_armel.deb \
       mnt2/pool/main/libg/libgdata/libgdata-common_0.12.0-1_all.deb \
       mnt2/pool/main/libg/libgdata/libgdata13_0.12.0-1_armel.deb \
       mnt2/pool/main/p/python-gdata/python-gdata_2.0.17+dfsg-1_all.deb \
       mnt2/pool/main/p/python-dateutil/python-dateutil_1.5+dfsg-0.1_all.deb \
       mnt2/pool/main/z/zlib/zlib1g_1.2.7.dfsg-13_armel.deb \
       mnt2/pool/main/o/openssl/libssl1.0.0_1.0.1e-2_armel.deb \
       mnt2/pool/main/n/ncurses/libncurses5_5.9-10_armel.deb \
       mnt2/pool/main/n/ncurses/ncurses-base_5.9-10_all.deb \
       mnt2/pool/main/n/ncurses/ncurses-bin_5.9-10_armel.deb \
       mnt2/pool/main/n/ncurses/ncurses-term_5.9-10_all.deb \
       mnt2/pool/main/n/ncurses/libncursesw5_5.9-10_armel.deb \
       mnt2/pool/main/d/db/libdb5.1_5.1.29-5_armel.deb \
       mnt2/pool/main/libx/libxau/libxau6_1.0.7-1_armel.deb \
       mnt2/pool/main/t/tiff/libtiff5_4.0.2-6+deb7u2_armel.deb \
       mnt2/pool/main/t/tiff3/libtiff4_3.9.6-11_armel.deb \
       mnt2/pool/main/d/directfb/libdirectfb-1.2-9_1.2.10.0-5_armel.deb \
       mnt2/pool/main/d/directfb/libdirectfb-extra_1.2.10.0-5_armel.deb \
       mnt2/pool/main/libx/libxdmcp/libxdmcp6_1.1.1-1_armel.deb \
       mnt2/pool/main/r/readline6/libreadline6_6.2+dfsg-0.1_armel.deb \
       mnt2/pool/main/r/readline6/readline-common_6.2+dfsg-0.1_all.deb \
       mnt2/pool/main/e/expat/libexpat1_2.1.0-1+deb7u1_armel.deb \
       mnt2/pool/main/s/sqlite3/libsqlite3-0_3.7.13-1+deb7u1_armel.deb \
       mnt2/pool/main/s/sqlite3/sqlite3_3.7.13-1+deb7u1_armel.deb \
       mnt2/pool/main/o/openssl/openssl_1.0.1e-2_armel.deb \
       mnt2/pool/main/p/pyopenssl/python-openssl_0.13-2+deb7u1_armel.deb \
       mnt2/pool/main/b/bzip2/bzip2_1.0.6-4_armel.deb \
       mnt2/pool/main/f/fonts-freefont/fonts-freefont-ttf_20120503-1_all.deb \
       mnt2/pool/main/libj/libjpeg6b/libjpeg62_6b1-3_armel.deb \
       mnt2/pool/main/libj/libjpeg8/libjpeg8_8d-1_armel.deb \
       mnt2/pool/main/libj/libjpeg8/libjpeg-progs_8d-1_armel.deb \
       mnt2/pool/main/p/python2.7/libpython2.7_2.7.3-6_armel.deb \
       mnt2/pool/main/p/python2.7/python2.7-minimal_2.7.3-6_armel.deb \
       mnt2/pool/main/p/python2.7/python2.7_2.7.3-6_armel.deb \
       mnt2/pool/main/libs/libsdl1.2/libsdl1.2debian_1.2.15-5_armel.deb \
       mnt2/pool/main/s/sdl-image1.2/libsdl-image1.2_1.2.12-2_armel.deb \
       mnt2/pool/main/s/sdl-mixer1.2/libsdl-mixer1.2_1.2.12-3_armel.deb \
       mnt2/pool/main/s/sdl-net1.2/libsdl-net1.2_1.2.8-2_armel.deb \
       mnt2/pool/main/s/sdl-ttf2.0/libsdl-ttf2.0-0_2.0.11-2_armel.deb \
       mnt2/pool/main/o/openssl-blacklist/openssl-blacklist_0.5-3_all.deb \
       mnt2/pool/main/libp/libpng/libpng12-0_1.2.49-1_armel.deb \
       mnt2/pool/main/o/openssl/libcrypto1.0.0-udeb_1.0.1e-2_armel.udeb \
       mnt2/pool/main/p/pulseaudio/libpulse0_2.0-6.1_armel.deb \
       mnt2/pool/main/a/alsa-lib/libasound2_1.0.25-4_armel.deb \
       mnt2/pool/main/libx/libx11/libx11-6_1.5.0-1+deb7u1_armel.deb \
       mnt2/pool/main/libx/libx11/libx11-xcb1_1.5.0-1+deb7u1_armel.deb \
       mnt2/pool/main/libx/libxext/libxext6_1.3.1-2+deb7u1_armel.deb \
       mnt2/pool/main/libc/libcaca/libcaca0_0.99.beta18-1_armel.deb \
       mnt2/pool/main/t/tslib/libts-0.0-0_1.0-11_armel.deb \
       mnt2/pool/main/libc/libcap2/libcap2_2.22-1.2_armel.deb \
       mnt2/pool/main/j/json-c/libjson0_0.10-1.2_armel.deb \
       mnt2/pool/main/libx/libxcb/libxcb1_1.8.1-2+deb7u1_armel.deb \
       mnt2/pool/main/s/slang2/libslang2_2.2.4-15_armel.deb \
       mnt2/pool/main/n/ncurses/libtinfo5_5.9-10_armel.deb \
       mnt2/pool/main/libi/libice/libice6_1.0.8-2_armel.deb \
       mnt2/pool/main/libs/libsm/libsm6_1.2.1-2_armel.deb \
       mnt2/pool/main/libx/libxtst/libxtst6_1.2.1-1+deb7u1_armel.deb \
       mnt2/pool/main/t/tcp-wrappers/libwrap0_7.6.q-24_armel.deb \
       mnt2/pool/main/libs/libsndfile/libsndfile1_1.0.25-5_armel.deb \
       mnt2/pool/main/liba/libasyncns/libasyncns0_0.8-4_armel.deb \
       mnt2/pool/main/u/util-linux/libuuid1_2.20.1-5.3_armel.deb \
       mnt2/pool/main/libx/libxi/libxi6_1.6.1-1+deb7u1_armel.deb \
       mnt2/pool/main/f/flac/libflac8_1.2.1-6_armel.deb \
       mnt2/pool/main/libo/libogg/libogg0_1.3.0-4_armel.deb \
       mnt2/pool/main/libv/libvorbis/libvorbisenc2_1.3.2-1.3_armel.deb \
       mnt2/pool/main/libv/libvorbis/libvorbis0a_1.3.2-1.3_armel.deb \
       python-requests_0.12.1-1_all.deb \
       mnt2/pool/main/s/six/python-six_1.1.0-2_all.deb \
       mnt2/pool/main/c/ca-certificates/ca-certificates_20130119_all.deb \
       mnt2/pool/main/c/curl/curl_7.26.0-1+wheezy6_armel.deb \
       mnt2/pool/main/c/curl/libcurl3-gnutls_7.26.0-1+wheezy6_armel.deb \
       mnt2/pool/main/c/curl/libcurl3_7.26.0-1+wheezy6_armel.deb \
       mnt2/pool/main/c/curl/libcurl4-openssl-dev_7.26.0-1+wheezy6_armel.deb \
       mnt2/pool/main/p/pycurl/python-pycurl_7.19.0-5_armel.deb \
       mnt2/pool/main/p/python-httplib2/python-httplib2_0.7.4-2+deb7u1_all.deb

FORCAST_SHA = d06ecd832c4490a5b19e7f3f5ae796eac33c1077

.PHONY: forcast
forcast : python-forcast.io-$(FORCAST_SHA)

python-forcast.io-$(FORCAST_SHA) : $(FORCAST_SHA).zip py-requests-backport.patch
	unzip $(FORCAST_SHA).zip
	patch -p0 < py-requests-backport.patch

$(FORCAST_SHA).zip :
	wget https://github.com/ZeevG/python-forcast.io/archive/$(FORCAST_SHA).zip

rfc3339.py :
	wget http://bitbucket.org/henry/rfc3339/src/tip/rfc3339.py

debian-7.3.0-armel-DVD-1.iso :
	wget http://cdimage.debian.org/debian-cd/7.3.0/armel/iso-dvd/debian-7.3.0-armel-DVD-1.iso

.extracted : $(DEBS) python-forcast.io-$(FORCAST_SHA) debian-7.3.0-armel-DVD-1.iso rfc3339.py
	mkdir -p root
	@ cd root && $(foreach var,$(DEBS),(ar p ../$(var) data.tar.gz | tar zx) || (ar p ../$(var) data.tar.xz | tar Jx);)
	rm -f root/bin/bunzip2 root/bin/bzcat
	cp root/bin/bzip2 root/bin/bunzip2
	cp root/bin/bzip2 root/bin/bzcat
	rm -rf root/usr/include root/usr/share/{man,doc}
	rm -rf root/usr/lib/python2.[56] root/usr/lib/pyshared/python2.6
	rm -f root/usr/lib/python2.7/dist-packages/pygame/freesansbold.ttf root/usr/share/pyshared/pygame/freesansbold.ttf
	rm -f root/usr/lib/python2.7/sitecustomize.py root/usr/lib/ssl/private root/usr/lib/ssl/openssl.cnf
	rm -f root/usr/share/terminfo/v/vt200 root/usr/share/terminfo/v/vt100-am root/usr/share/terminfo/v/vt220 root/usr/share/terminfo/v/vt100 root/usr/share/terminfo/s/sun1 root/usr/share/terminfo/s/sun root/usr/share/terminfo/s/sun2 root/usr/share/terminfo/c/cons25 root/usr/share/terminfo/n/nxterm root/usr/share/terminfo/a/ansi80x25 root/usr/share/terminfo/a/ansis root/usr/share/terminfo/x/xterm-color root/usr/share/terminfo/x/xterm-old root/usr/share/terminfo/x/xterm-r6 root/usr/share/pyshared/pygame/freesansbold.ttf
	rm -rf root/usr/share/terminfo/N
	rm -rf root/usr/share/terminfo
	rm -f root/usr/lib/ssl/certs
	mkdir -p root/etc/ssl/certs
	find -L root/usr/share/ca-certificates -type f -name '*.crt' | while read crt; do cat "$$crt" >> root/etc/ssl/certs/ca-certificates.crt; done
	cp root/usr/share/fonts/truetype/freefont/FreeSansBold.ttf root/usr/lib/python2.7/dist-packages/pygame/freesansbold.ttf
	find root -type l -exec cp --dereference --recursive '{}' '{}'.dereferenced \;
	find root -name \*dereferenced -exec rename .dereferenced "" {} \;
	mkdir -p root/usr/lib/python2.7/dist-packages
	cp rfc3339.py root/usr/lib/python2.7/dist-packages/
	cp meteocons.ttf root/
	cp -R python-forcast.io-$(FORCAST_SHA)/forecastio root/usr/lib/python2.7/dist-packages/
	touch $@

root.tar.gz : .extracted
	tar czf $@ root

.PHONY: upload
upload : root.tar.gz 
	curl -T root.tar.gz ftp://192.168.0.24/mnt/onboard/ --user anonymous:anonymous

.PHONY: clean
clean :
	rm -f .extracted
	rm -rf root
	rm -rf python-forcast.io-$(FORCAST_SHA) $(FORCAST_SHA).zip
	rm -f ld-result.txt ld-result-filtered.txt ld-result-filtered-notfound.txt
	rm -f rfc3339.py

ld-result.txt : debian-7.3.0-armel-DVD-1.iso
	mkdir -p dep-tree
	@ cd dep-tree && $(foreach var,$(DEBS),(ar p ../$(var) data.tar.gz | tar zx) || (ar p ../$(var) data.tar.xz | tar Jx);)
	mv dep-tree/lib/arm-linux-gnueabi/* dep-tree/lib
	mv dep-tree/usr/lib/arm-linux-gnueabi/* dep-tree/usr/lib
	find dep-tree -type f | grep -v py$$ | grep -v terminfo | xargs -L 1 ~/x-tools/arm-unknown-linux-gnueabi/bin/arm-unknown-linux-gnueabi-ldd --root dep-tree &> ld-result.txt

ld-result-filtered.txt : ld-result.txt
	grep -v ^readelf ld-result.txt > ld-result-filtered.txt

ld-result-filtered-notfound.txt : ld-result-filtered.txt
	grep "not found" ld-result-filtered.txt | sort | uniq > ld-result-filtered-notfound.txt

