#!/bin/bash

sed -i 's/runscript/openrc-run/' /mnt/gentoo/etc/init.d/*

chroot /mnt/gentoo /bin/bash <<'EOF'
cd /usr/src/linux && make clean
etc-update --automode 5
emerge --quiet-build -C sys-kernel/gentoo-sources
emerge --depclean
EOF

rm -rf /mnt/gentoo/usr/portage
rm -rf /mnt/gentoo/tmp/*
rm -rf /mnt/gentoo/var/log/*
rm -rf /mnt/gentoo/var/tmp/*

chroot /mnt/gentoo /bin/bash <<'EOF'
wget http://frippery.org/uml/zerofree-1.0.4.tgz
tar xvzf zerofree-*.tgz
cd zerofree*/
make
EOF

mv /mnt/gentoo/zerofree* ./
cd zerofree*/

mount -o remount,ro /mnt/gentoo
./zerofree ${BLK_DEV}3

