#!/bin/bash

cp $SCRIPTS/scripts/kernel.config /mnt/gentoo/tmp/

chroot /mnt/gentoo /bin/bash <<'EOF'
echo sys-kernel/vanilla-kernel ~amd64 >> \
  /etc/portage/package.accept_keywords/kernel
emerge app-portage/gentoolkit
euse -p sys-kernel/vanilla-kernel -E initramfs
cp /tmp/kernel.config /usr/src/linux/.config
emerge sys-kernel/vanilla-kernel sys-kernel/genkernel sys-kernel/linux-firmware
cd /usr/src/linux
#genkernel --install --symlink --no-zfs --no-btrfs --oldconfig --loglevel=1 all
EOF
