#!/bin/bash

env

sgdisk \
  -n 1:0:+128M -t 1:8300 -c 1:"linux-boot" \
  -n 2:0:+32M  -t 2:ef02 -c 2:"bios-boot"  \
  -n 4:0:0     -t 4:8300 -c 4:"linux-root" \
  -p ${BLK_DEV}

sync

mkfs.ext2 ${BLK_DEV}1
mkfs.ext4 ${BLK_DEV}3

