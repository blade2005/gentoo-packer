#!/bin/bash

cat << 'EOF' >> /mnt/gentoo/etc/portage/make.conf
USE="$USE cron vim vim-syntax nano nano-syntax python -systemd -gtk -gnome -kde -qt4 -alsa curl lzma lz0 nmap ssl readline ncurses ruby logrotate symlink"
EMERGE_DEFAULT_OPTS="${EMERGE_DEFAULT_OPTS} --quiet-build --quiet "
ACCEPT_LICENSE="@FREE @BINARY-REDISTRIBUTABLE"

EOF

chroot /mnt/gentoo /bin/bash <<'EOF'
mkdir /usr/portage
cd /etc/portage
rm make.profile
ln -s ../../var/db/repos/gentoo/profiles/default/linux/amd64/17.1 make.profile
emerge-webrsync
emerge --sync -q
EOF
