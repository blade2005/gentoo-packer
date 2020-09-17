#!/bin/bash

cp $SCRIPTS/scripts/kernel.config /mnt/gentoo/tmp/kernel.config
cp $SCRIPTS/scripts/authorized_keys /mnt/gentoo/tmp/authorized_keys

chroot /mnt/gentoo /bin/bash <<'EOF'
echo sys-kernel/vanilla-kernel ~amd64 >> \
  /etc/portage/package.accept_keywords/kernel
emerge app-portage/gentoolkit
euse -p sys-kernel/vanilla-kernel -E initramfs
cp /tmp/kernel.config /usr/src/linux/.config
emerge \
  sys-kernel/vanilla-sources \
  sys-kernel/genkernel \
  sys-kernel/linux-firmware
cd /usr/src/linux
genkernel \
  --install \
  --lvm \
  --symlink \
  --no-zfs \
  --no-btrfs \
  --oldconfig \
  --loglevel=1 \
  --microcode=all \
  --ssh-authorized-keys-file=/tmp/authorized_keys \
  --ssh \
  --kernel-config=/tmp/kernel.config \
  --no-menuconfig \
  --mountboot \
  --microcode \
  --module-rebuild \
  all
EOF
