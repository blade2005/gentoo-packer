#!/bin/bash

cp $SCRIPTS/scripts/kernel.config /mnt/gentoo/tmp/

chroot /mnt/gentoo /bin/bash <<'EOF'
emerge --quiet-build sys-kernel/vanilla-kernel
emerge --quiet-build sys-kernel/genkernel
cd /usr/src/linux
mv /tmp/kernel.config .config
euse -p sys-kernel/vanilla-kernel -E initramfs
echo sys-kernel/vanilla-kernel ~amd64 >> \
  /etc/portage/package.accept_keywords/kernel
genkernel --install --symlink --no-zfs --no-btrfs --oldconfig --loglevel=1 all
emerge --quiet-build -c sys-kernel/genkernel
EOF
