#!/bin/bash

tarball=stage3-amd64-nomultilib-$STAGE3.tar.bz2

mount ${BLK_DEV}4 /mnt/gentoo
df -h /mnt/gentoo
sleep 10
cd /mnt/gentoo
wget -q http://distfiles.gentoo.org/releases/amd64/autobuilds/$STAGE3/$tarball
tar xjpf $tarball
rm -f $tarball
