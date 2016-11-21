#!/bin/bash

chroot /mnt/gentoo /bin/bash <<'EOF'
mkdir /usr/portage
emerge-webrsync -q
emerge --ask --update --deep --newuse @world
EOF
