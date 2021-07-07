#!/bin/bash

mount --types proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev 

chroot /mnt/gentoo /bin/bash << EOF
mount ${BLK_DEV}2 /boot
EOF

mount
df -h
