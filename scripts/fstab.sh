#!/bin/bash

cat > /mnt/gentoo/etc/fstab <<DATA
# <fs>		<mount>	<type>	<opts>		<dump/pass>
${BLK_DEV}1	/boot	ext2	noauto,noatime	1 2
${BLK_DEV}3	/	ext4	noatime		0 1
DATA
EOF
