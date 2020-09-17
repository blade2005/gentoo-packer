#!/bin/bash

cp $SCRIPTS/scripts/kernel.config /mnt/gentoo/tmp/kernel.config
cp $SCRIPTS/scripts/authorized_keys /mnt/gentoo/tmp/authorized_keys
cat << 'EOF' >> /mnt/gentoo/etc/portage/package.accept_keywords/kernel
sys-kernel/vanilla-kernel ~amd64
sys-kernel/kergen
EOF

chroot /mnt/gentoo /bin/bash <<'EOF'
emerge -n \
  sys-kernel/vanilla-sources \
  sys-kernel/genkernel \
  sys-kernel/linux-firmware \
  sys-kernel/linux-headers \
  sys-kernel/kergen
cp /tmp/kernel.config /usr/src/linux/.config
yes | kergen -g
genkernel \
  --install \
  --lvm \
  --symlink \
  --loglevel=1 \
  --oldconfig \
  --no-zfs \
  --no-btrfs \
  --ssh-authorized-keys-file=/tmp/authorized_keys \
  --ssh \
  --microcode=all \
  --microcode \
  --no-menuconfig \
  --mountboot \
  --module-rebuild \
  --makeopts=-j$(grep -c proc /proc/cpuinfo) \
  all
EOF

