#!/bin/sh

set -eu

rootfs="$1"

ln -sf /dev/null $1/etc/systemd/system/systemd-suspend.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/systemd-hibernate.service 2>/dev/null || true

ln -sf /dev/null $1/etc/systemd/system/apt-daily.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/apt-daily.timer 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/apt-daily-upgrade.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/apt-daily-upgrade.timer 2>/dev/null || true

ln -sf /dev/null $1/etc/systemd/system/dhcpd.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/NetworkManager-wait-online.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/systemd-networkd-wait-online.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/NetworkManager.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/wpa_supplicant.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/avahi-daemon.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/ModemManager.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/man-db.timer 2>/dev/null || true
# ln -sf /dev/null $1/etc/systemd/system/systemd-fsck.service 2>/dev/null || true
# enable fsck after boot.
# ln -sf /dev/null $1/etc/systemd/system/getty@*.service 2>/dev/null || true

for unit in "$1"/etc/systemd/system/getty@*.service; do
  [ -e "$unit" ] || continue
  ln -sf /dev/null "$unit"
done

sed -i -e 's/^WantedBy=multi-user\.target$/WantedBy=sysinit.target/' "$1/lib/systemd/system/seatd.service"

# ln -sf /dev/null $1/lib/systemd/system/plymouth-quit.service 2>/dev/null || true

ln -sf /dev/null $1/etc/systemd/system/systemd-logind.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/getty-static.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/getty@.service 2>/dev/null || true
# ln -sf /dev/null $1/etc/systemd/system/getty.target 2>/dev/null || true

# vconsole-setup, console-setup.service, keyboard-setup.service, serial-getty@ttyAMA0.service, serial-getty@ttyS0.service

# if [ -f "$1/etc/systemd/logind.conf" ]; then
#   sed -i \
#     -e 's/^[[:space:]]*#\?[[:space:]]*NAutoVTs=.*/NAutoVTs=1/' \
#     -e 's/^[[:space:]]*#\?[[:space:]]*ReserveVT=.*/ReserveVT=1/' \
#     "$1/etc/systemd/logind.conf"
# fi

FSTAB="$1/etc/fstab"

sed -Ei '
  /^\s*#/b
  /^\s*$/b
  /(^|,|\s)fastboot(,|\s|$)/b
  s/^(\S+[[:space:]]+\S+[[:space:]]+\S+[[:space:]]+)(\S+)/\1\2,fastboot/
' "$FSTAB"

chmod -R 755 "$1/opt/app"
chmod +x "$1/usr/sbin/eeprom-tool.sh"

rm -rf "$1/usr/share/plymouth/themes/bgrt" "$1/usr/share/plymouth/themes/fade-in" \
       "$1/usr/share/plymouth/themes/glow" "$1/usr/share/plymouth/themes/script" \
       "$1/usr/share/plymouth/themes/solar" "$1/usr/share/plymouth/themes/spinfinity" \
       "$1/usr/share/plymouth/themes/details"
       
