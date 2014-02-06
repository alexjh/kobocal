#!/bin/sh

cd /mnt/onboard/root && \
    PYTHONHOME=/mnt/onboard/root/usr \
    PYTHONPATH=/mnt/onboard/root/usr/lib/python2.7 \
    LD_LIBRARY_PATH=/mnt/onboard/root/usr/lib/arm-linux-gnueabi:/mnt/onboard/root/lib/arm-linux-gnueabi:/mnt/onboard/root/usr/lib/arm-linux-gnueabi/pulseaudio \
    REQUESTS_CA_BUNDLE=/mnt/onboard/root/etc/ssl/certs/ca-certificates.crt \
    usr/bin/python2.7 ../kobocal.py -l
