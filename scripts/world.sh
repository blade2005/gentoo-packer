#!/bin/bash


chroot /mnt/gentoo /bin/bash <<'EOF'
emerge  --backtrack=100 --verbose-conflicts --update --changed-use --deep --with-bdeps=y @world
EOF
