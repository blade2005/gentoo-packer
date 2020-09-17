#!/bin/bash

if [ $PACKER_BUILDER_TYPE == "virtualbox-iso" ];then
chroot /mnt/gentoo /bin/bash <<'EOF'
emerge --quiet-build "=virtual/linux-sources-1" --autounmask-write
etc-update --automode -5
emerge --quiet-build "=virtual/linux-sources-1"
emerge --quiet-build ">=app-emulation/virtualbox-guest-additions-4.3" --autounmask-write
etc-update --automode -5
emerge --quiet-build ">=app-emulation/virtualbox-guest-additions-4.3"
rc-update add virtualbox-guest-additions default
EOF
fi
