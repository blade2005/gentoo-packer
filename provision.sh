#!/bin/bash
set -e
if [[ -z $STAGE3 ]]
then
  echo "STAGE3 environment variable must be set to a timestamp."
  exit 1
fi

if [[ -z $SCRIPTS ]]
then
  SCRIPTS=.
fi

if [ $PACKER_BUILDER_TYPE == "qemu" ];then
    export BLK_DEV=/dev/vda
else
    export BLK_DEV=/dev/sda
fi

chmod +x $SCRIPTS/scripts/*.sh

for script in          \
  partition            \
  stage3               \
  mounts               \
  resolv.conf          \
  portage              \
  locale               \
  timezone             \
  fstab                \
  kernel               \
  grub                 \
  $PACKER_BUILDER_TYPE \
  network              \
  vagrant              \
  extra                \
  cleanup
do
  "$SCRIPTS/scripts/$script.sh"
done

echo "All done."
