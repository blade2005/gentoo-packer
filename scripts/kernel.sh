#!/bin/bash

cp $SCRIPTS/scripts/kernel.config /mnt/gentoo/tmp/kernel.config
cp $SCRIPTS/scripts/authorized_keys /mnt/gentoo/tmp/authorized_keys
echo sys-kernel/vanilla-kernel ~amd64 >> \
  /mnt/gentoo/etc/portage/package.accept_keywords/kernel

chroot /mnt/gentoo /bin/bash <<'EOF'
emerge -n \
  sys-kernel/vanilla-sources \
  sys-kernel/genkernel \
  sys-kernel/linux-firmware
genkernel \
  --install \
  --lvm \
  --symlink \
  --no-zfs \
  --no-btrfs \
  --oldconfig \
  --loglevel=1 \
  all
EOF
#  --kernel-config=/tmp/kernel.config \
#  --ssh-authorized-keys-file=/tmp/authorized_keys \
#  --ssh \
#  --microcode=all \
#  --microcode \
#  --no-menuconfig \
#  --mountboot \
#  --module-rebuild \
#  --makeopts=-j$(grep -c proc /proc/cpuinfo) \

