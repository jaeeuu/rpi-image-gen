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

sed -i -e 's/^WantedBy=multi-user\.target$/WantedBy=local-fs-pre.target/' "$1/lib/systemd/system/seatd.service"

# ln -sf /dev/null $1/lib/systemd/system/plymouth-quit.service 2>/dev/null || true

# ln -sf /dev/null $1/etc/systemd/system/systemd-logind.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/getty-static.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/getty@.service 2>/dev/null || true
# ln -sf /dev/null $1/etc/systemd/system/serial-getty@ttyAMA10.service 2>/dev/null || true
# ln -sf /dev/null $1/etc/systemd/system/getty.target 2>/dev/null || true

# vconsole-setup, console-setup.service, keyboard-setup.service, serial-getty@ttyAMA0.service, serial-getty@ttyS0.service

ln -sf /dev/null $1/etc/systemd/system/systemd-logind.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/systemd-tpm2-setup-early.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/systemd-pcrmachine.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/systemd-hibernate-clear.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/sys-kernel-tracing.mount 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/sys-kernel-debug.mount 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/dev-hugepages.mount 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/systemd-pcrlock.socket 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/systemd-pcrextend.socket 2>/dev/null || true

chmod -R 755 "$1/opt/app"
chmod +x "$1/opt/eeprom-tool.sh"

# rm -rf "$1/usr/share/plymouth/themes/bgrt" "$1/usr/share/plymouth/themes/fade-in" \
#        "$1/usr/share/plymouth/themes/glow" "$1/usr/share/plymouth/themes/script" \
#        "$1/usr/share/plymouth/themes/solar" "$1/usr/share/plymouth/themes/spinfinity" \
#        "$1/usr/share/plymouth/themes/details"

rm -rf "$1/usr/share/doc"/* "$1/usr/share/man"/* "$1/usr/share/locale/"/* "$1/usr/share/info/"/* "$1/usr/share/lintian/"/* \
        "$1/usr/share/linda/"/* "$1/usr/share/debhelper/"/* "$1/usr/share/pixmaps/"/* "$1/usr/share/applications/"/* \
        "$1/usr/share/help/"/* "$1/usr/share/gtk-doc"/* "$1/usr/share/icons"/* "$1/usr/share/themes"/* \
        "$1/usr/share/sounds"/* "$1/usr/share/backgrounds"/* "$1/usr/share/pkgconfig"/*

rm -rf "$1/etc/apt"/* "$1/etc/dpkg"/* "$1/usr/bin/dpkg"/*
rm -rf "$1/var/cache/*" "$1/var/lib/apt/lists/" "$1/var/tmp"/*
rm -rf "$1/tmp"/*

find "$1/var/log" -type f -exec truncate -s 0 {} \; 2>/dev/null || true

# if [ -d "$1/usr/share/zoneinfo" ]; then
#     cd "$1/usr/share/zoneinfo"
#     find . -type f ! -path "./Asia/Seoul" ! -name "UTC" ! -name "GMT" -delete 2>/dev/null || true
#     find . -type d -empty -delete 2>/dev/null || true
# fi

rm -f $1/boot/firmware/initrd.img-*

