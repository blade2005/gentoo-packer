#!/bin/bash

cp $SCRIPTS/scripts/kernel.config /mnt/gentoo/tmp/kernel.config
cp $SCRIPTS/scripts/authorized_keys /mnt/gentoo/tmp/authorized_keys

chroot /mnt/gentoo /bin/bash <<'EOF'
echo sys-kernel/vanilla-kernel ~amd64 >> \
  /etc/portage/package.accept_keywords/kernel
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
  --kernel-config=/tmp/kernel.config \
  all
EOF
#  --ssh-authorized-keys-file=/tmp/authorized_keys \
#  --ssh \
#  --microcode=all \
#  --microcode \
#  --no-menuconfig \
#  --mountboot \
#  --module-rebuild \
#  --makeopts=-j$(grep -c proc /proc/cpuinfo) \

