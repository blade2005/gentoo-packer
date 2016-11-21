#!/bin/bash

cp $SCRIPTS/scripts/kernel.config /mnt/gentoo/tmp/

chroot /mnt/gentoo /bin/bash <<'EOF'
emerge --quiet-build sys-kernel/gentoo-sources
emerge --quiet-build sys-kernel/genkernel
cd /usr/src/linux
mv /tmp/kernel.config .config
genkernel --install --symlink --no-zfs --no-btrfs --oldconfig all
emerge --quiet-build -c sys-kernel/genkernel
EOF
