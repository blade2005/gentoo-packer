#!/bin/bash


mount ${BLK_DEV}3 /mnt/gentoo
df -h /mnt/gentoo
sleep 10
cd /mnt/gentoo
wget -q -O stage3.tar.xz https://gentoo.osuosl.org/releases/amd64/autobuilds/$(curl -s https://gentoo.osuosl.org/releases/amd64/autobuilds/latest-stage3-amd64.txt | grep -v ^# |awk '{print $1}')
tar xjpf $tarball
rm -f $tarball
