#!/bin/bash

cd /
mount ${BLK_DEV}2 /mnt/gentoo/boot
mount -t proc proc /mnt/gentoo/proc
mount --rbind /dev /mnt/gentoo/dev
mount --rbind /sys /mnt/gentoo/sys

mount
df -h
