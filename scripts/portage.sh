#!/bin/bash

chroot /mnt/gentoo /bin/bash <<'EOF'
mkdir /usr/portage
emerge-webrsync -q
emerge --quiet-build --ask --update --deep --newuse @world
EOF
