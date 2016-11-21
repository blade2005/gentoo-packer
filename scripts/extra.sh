#!/bin/bash

chroot /mnt/gentoo /bin/bash <<'EOF'
emerge --quiet-build -U --autounmask y --autounmask-write y sys-apps/pciutils app-admin/superadduser app-antivirus/clamav app-editors/vim app-misc/screen app-portage/gentoolkit app-portage/portage-utils dev-util/strace dev-vcs/git games-misc/fortune-mod mail-client/mutt mail-mta/sendmail net-analyzer/iftop net-analyzer/tcptraceroute net-analyzer/traceroute net-dns/bind-tools net-misc/curl net-misc/dhcpcd net-misc/netifrc net-misc/openntpd net-misc/whois sys-apps/ethtool sys-apps/lshw sys-apps/mlocate sys-fs/dosfstools sys-process/at  sys-process/htop sys-process/iotop sys-process/lsof www-client/links www-client/lynx net-analyzer/gnu-netcat sys-block/parted app-admin/sysstat
EOF

chroot /mnt/gentoo /bin/bash <<'EOF'
echo 's0:12345:respawn:/sbin/agetty -L 115200 ttyS0 vt100
s1:12345:respawn:/sbin/agetty -L 115200 ttyS1 vt100' >> /etc/inittab
EOF
