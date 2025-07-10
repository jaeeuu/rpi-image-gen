#!/bin/sh

set -eu

rootfs="$1"

ln -sf /dev/null $1/etc/systemd/system/systemd-suspend.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/systemd-hibernate.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/getty-static.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/apt-daily.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/apt-daily.timer 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/apt-daily-upgrade.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/apt-daily-upgrade.timer 2>/dev/null || true
if [ -f "$1/etc/systemd/logind.conf" ]; then
  sed -i \
    -e 's/^[[:space:]]*#\?[[:space:]]*NAutoVTs=.*/NAutoVTs=1/' \
    -e 's/^[[:space:]]*#\?[[:space:]]*ReserveVT=.*/ReserveVT=1/' \
    "$1/etc/systemd/logind.conf"
fi
