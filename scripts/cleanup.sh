#!/bin/bash

echo "Fixing any legacy scripts which use runscript instead of openrc-run"
sed -i 's/runscript/openrc-run/' /mnt/gentoo/etc/init.d/*

chroot /mnt/gentoo /bin/bash <<'EOF'
etc-update --automode -5
emerge --quiet-build -C sys-kernel/gentoo-sources
emerge --depclean
EOF

rm -rf \
	/mnt/gentoo/usr/portage \
	/mnt/gentoo/tmp/* \
	/mnt/gentoo/var/log/* \
	/mnt/gentoo/var/tmp/*

chroot /mnt/gentoo /bin/bash <<'EOF'
wget http://frippery.org/uml/zerofree-1.0.4.tgz
tar xvzf zerofree-*.tgz
cd zerofree*/
make
EOF

chroot /mnt/gentoo /bin/bash <<'EOF'
find /etc/init.d/ -maxdepth 1 -exec {} stop \; 
EOF

rsync -avp /mnt/gentoo/zerofree*/ zerofree/

mount | \
	grep /mnt/gentoo | \
	tac | \
	awk '{print $3}' | \
	xargs -n1 umount

zerofree*/zerofree ${BLK_DEV}3

