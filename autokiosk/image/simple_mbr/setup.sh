#!/bin/bash

set -eu

cat > $IMAGEMOUNTPATH/etc/fstab <<EOF
LABEL=ROOT  /               ext4  rw,noatime,errors=remount-ro,commit=30 0 0
LABEL=BOOT  /boot/firmware  vfat  defaults,noatime,errors=remount-ro,commit=30 0 0
EOF
