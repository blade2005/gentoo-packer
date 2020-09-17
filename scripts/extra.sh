#!/bin/bash

cp $SCRIPTS/scripts/blade-recommended.set /mnt/gentoo/etc/portage/sets/blade-recommended
chroot /mnt/gentoo /bin/bash <<'EOF'
echo app-portage/pgo >> /etc/portage/package.accept_keywords/portage
echo sys-kernel/vanilla-sources >> /etc/portage/package.accept_keywords/kernel
emerge --quiet-build -U --autounmask y --autounmask-write y \
@blade-recommended
EOF

chroot /mnt/gentoo /bin/bash <<'EOF'
echo 's0:12345:respawn:/sbin/agetty -L 115200 ttyS0 vt100
s1:12345:respawn:/sbin/agetty -L 115200 ttyS1 vt100' >> /etc/inittab
EOF
