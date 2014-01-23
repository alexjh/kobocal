# Run on Kobo:
# [root@(none) root]# PYTHONHOME=/mnt/onboard/root/usr PYTHONPATH=/mnt/onboard/roo
# t/usr/lib/python2.6 LD_LIBRARY_PATH=/mnt/onboard/root/usr/lib:/mnt/onboard/root/
# lib usr/bin/python2.6

.PHONY: default all
default : all

all : .python-pygame_1.8.1release-2+b1_armel.deb.extracted

#       mnt/pool/main/p/python-numpy/python-numpy_1.4.1-5_armel.deb \
#       mnt/pool/main/b/blas/libblas3gf_1.2-8_armel.deb \
#       mnt/pool/main/l/lapack/liblapack3gf_3.2.1-8_armel.deb \
#       mnt/pool/main/libv/libvorbis/libvorbisfile3_1.3.1-1+squeeze1_armel.deb \
#       mnt/pool/main/libo/libogg/libogg0_1.2.0~dfsg-1_armel.deb \
#       mnt/pool/main/libv/libvorbis/libvorbis0a_1.3.1-1+squeeze1_armel.deb \
#       mnt/pool/main/s/smpeg/libsmpeg0_0.4.5+cvs20030824-2.2_armel.deb \
#       mnt/pool/main/libm/libmikmod/libmikmod2_3.1.11-a-6.3_armel.deb \
#       mnt/pool/main/n/ncurses/libncursesw5_5.7+20100313-5_armel.deb \
#       mnt/pool/main/libx/libx11/libx11-6_1.3.3-4+squeeze1_armel.deb \
#       mnt/pool/main/libx/libxcb/libxcb1_1.6-1+squeeze1_armel.deb \
#       mnt/pool/main/libx/libx11/libx11-data_1.3.3-4+squeeze1_all.deb \

DEBS = mnt/pool/main/p/pygame/python-pygame_1.8.1release-2+b1_armel.deb \
       mnt/pool/main/a/alsa-lib/libasound2_1.0.23-2.1_armel.deb \
       mnt/pool/main/libs/libsdl1.2/libsdl1.2debian_1.2.14-6.1_armel.deb \
       mnt/pool/main/libs/libsdl1.2/libsdl1.2debian-alsa_1.2.14-6.1_armel.deb \
       mnt/pool/main/s/sdlgfx/libsdl-gfx1.2-4_2.0.20-1.1_armel.deb \
       mnt/pool/main/s/sdl-image1.2/libsdl-image1.2_1.2.10-2+b2_armel.deb \
       mnt/pool/main/s/sdl-mixer1.2/libsdl-mixer1.2_1.2.8-6.3_armel.deb \
       mnt/pool/main/s/sdl-net1.2/libsdl-net1.2_1.2.7-2_armel.deb \
       mnt/pool/main/s/sdl-ttf2.0/libsdl-ttf2.0-0_2.0.9-1_armel.deb \
       mnt/pool/main/libp/libpng/libpng12-0_1.2.44-1+squeeze4_armel.deb \
       mnt/pool/main/p/python2.6/python2.6_2.6.6-8+b1_armel.deb \
       mnt/pool/main/p/python2.6/python2.6-minimal_2.6.6-8+b1_armel.deb \
       mnt/pool/main/libj/libjpeg6b/libjpeg62_6b1-1_armel.deb \
       mnt/pool/main/t/ttf-freefont/ttf-freefont_20090104-7_all.deb \
       mnt/pool/main/b/bzip2/libbz2-1.0_1.0.5-6+squeeze1_armel.deb \
       mnt/pool/main/o/openssl/openssl_0.9.8o-4squeeze14_armel.deb \
       mnt/pool/main/s/sqlite3/libsqlite3-0_3.7.3-1_armel.deb \
       mnt/pool/main/e/expat/libexpat1_2.0.1-7+squeeze1_armel.deb \
       mnt/pool/main/r/readline6/libreadline6_6.1-3_armel.deb \
       mnt/pool/main/libx/libxdmcp/libxdmcp6_1.0.3-2_armel.deb \
       mnt/pool/main/f/freetype/libfreetype6_2.4.2-2.1+squeeze4_armel.deb \
       mnt/pool/main/d/directfb/libdirectfb-1.2-9_1.2.10.0-4_armel.deb \
       mnt/pool/main/t/tiff/libtiff4_3.9.4-5+squeeze10_armel.deb \
       mnt/pool/main/libx/libxau/libxau6_1.0.6-1_armel.deb \
       mnt/pool/main/d/db4.8/libdb4.8_4.8.30-2_armel.deb \
       mnt/pool/main/n/ncurses/libncurses5_5.7+20100313-5_armel.deb \
       mnt/pool/main/t/tslib/libts-0.0-0_1.0-7_armel.deb \
       mnt/pool/main/o/openssl/libcrypto0.9.8-udeb_0.9.8o-4squeeze14_armel.udeb \
       mnt/pool/main/o/openssl/libssl0.9.8_0.9.8o-4squeeze14_armel.deb \
       mnt/pool/main/z/zlib/zlib1g_1.2.3.4.dfsg-3_armel.deb \
       mnt/pool/main/s/sysfsutils/libsysfs2_2.1.0+repack-1_armel.deb \
       mnt/pool/main/p/python-dateutil/python-dateutil_1.4.1-3_all.deb \
       mnt/pool/main/libg/libgdata/libgdata7_0.6.4-2+squeeze1_armel.deb \
       mnt/pool/main/libg/libgdata/libgdata-common_0.6.4-2+squeeze1_all.deb \
       mnt/pool/main/p/python-gdata/python-gdata_2.0.8-1.1_all.deb


.extracted : $(DEBS)
	mkdir -p root
	cd root && $(foreach var,$(DEBS),ar p ../$(var) data.tar.gz | tar zx;)
	rm -rf root/usr/include root/usr/share/{man,doc}
	rm -rf root/usr/lib/python2.5
	cp -R root/usr/share/pyshared/* root/usr/lib/python2.6/dist-packages/
	rm -f root/usr/lib/python2.6/dist-packages/pygame/freesansbold.ttf
	rm -f root/usr/lib/python2.6/sitecustomize.py root/usr/lib/ssl/private root/usr/lib/ssl/openssl.cnf
	rm -f root/usr/lib/ssl/certs
	cp root/usr/share/fonts/truetype/freefont/FreeSansBold.ttf root/usr/lib/python2.6/dist-packages/pygame/freesansbold.ttf
	mv root/usr/share/python-support/python-dateutil/dateutil root/usr/lib/python2.6/dist-packages/
	find root -type l -exec cp --dereference --recursive '{}' '{}'.dereferenced \;
	find root -name \*dereferenced -exec rename .dereferenced "" {} \;
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

ld-result.txt : .extracted
	find root -type f | xargs -L 1 ~/x-tools/arm-unknown-linux-gnueabi/bin/arm-unknown-linux-gnueabi-ldd --root root &> ld-result.txt

ld-result-filtered.txt : ld-result.txt
	grep -v ^readelf ld-result.txt > ld-result-filtered.txt

ld-result-filtered-notfound.txt : ld-result-filtered.txt
	grep "not found" ld-result-filtered.txt | sort | uniq > ld-result-filtered-notfound.txt

