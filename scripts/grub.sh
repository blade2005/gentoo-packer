#!/bin/bash

chroot /mnt/gentoo /bin/bash <<'EOF'
set -x
emerge --quiet-build ">=sys-boot/grub-2.0"
echo "set timeout=0" >> /etc/grub.d/40_custom

cat << 'EOD' >> /etc/default/grub
GRUB_CMDLINE_LINUX="$GRUB_CMDLINE_LINUX console=tty0 console=ttyS0,38400n8"
GRUB_CMDLINE_LINUX_DEFAULT="dolvm dosshd"
## Serial console
GRUB_TERMINAL=serial
GRUB_SERIAL_COMMAND="serial --speed=38400 --unit=0 --word=8 --parity=no --stop=1"
EOD

grub-install ${BLK_DEV}
grub-mkconfig -o /boot/grub/grub.cfg
EOF
