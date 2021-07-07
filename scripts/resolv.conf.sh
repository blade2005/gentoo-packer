#!/bin/bash

cat << 'EOF' > /mnt/gentoo/etc/resolv.conf
nameserver 1.1.1.1
EOF
