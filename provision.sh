#!/bin/bash
set -e
if [[ -z $SCRIPTS ]]
then
  SCRIPTS=.
fi

chmod +x $SCRIPTS/scripts/*.sh

for script in          \
  partition            \
  stage3               \
  mounts               \
  resolv.conf          \
  repos                \
  configure-portage    \
  locale               \
  world                \
  timezone             \
  fstab                \
  kernel               \
  grub                 \
  network              \
  extra                \
  cleanup
do
  "$SCRIPTS/scripts/$script.sh"
done

echo "All done."
