#!/bin/bash

set -eu

LABEL="$1"
BOOTPARTUUID=a1b2c3d4-01
ROOTPARTUUID=a1b2c3d4-02

case $LABEL in
   ROOT)
      cat << EOF > $IMAGEMOUNTPATH/etc/fstab
LABEL=ROOT  /               ext4  rw,noatime,nodiratime,errors=remount-ro,commit=30 0 0
LABEL=BOOT  /boot/firmware  vfat  defaults,rw,noatime 0 0
EOF
      ;;
   BOOT)
      sed -i "s|root=\([^ ]*\)|root=PARTUUID=${ROOTPARTUUID}|" $IMAGEMOUNTPATH/cmdline.txt
      ;;
   *)
      ;;
esac
