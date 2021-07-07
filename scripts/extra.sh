#!/bin/bash

cp $SCRIPTS/scripts/blade-recommended.set /mnt/gentoo/etc/portage/sets/blade-recommended

echo app-portage/pgo >> /mnt/gentoo/etc/portage/package.accept_keywords/portage
echo sys-kernel/vanilla-sources >> /mnt/gentoo/etc/portage/package.accept_keywords/kernel

chroot /mnt/gentoo /bin/bash <<'EOF'
euse -p media-libs/libglvnd -E X
emerge \
  -n \
  --quiet-build \
  -U \
  --autounmask y \
  --autounmask-write y \
  @blade-recommended
EOF

echo 's0:12345:respawn:/sbin/agetty -L 115200 ttyS0 vt100
s1:12345:respawn:/sbin/agetty -L 115200 ttyS1 vt100' >> /mnt/gentoo/etc/inittab

chroot /mnt/gentoo /bin/bash << 'EOF'
for i in acpid cronie docker sshd net.eth0 ntpd mdadm lvm libvirtd \
libvirt-guests local sysstat virtlogd syslog-ng; do
  rc-update add $i
done
EOF
