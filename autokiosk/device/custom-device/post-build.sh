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

ln -sf /dev/null $1/etc/systemd/system/dhcpd.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/NetworkManager-wait-online.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/systemd-networkd-wait-online.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/NetworkManager.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/wpa_supplicant.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/avahi-daemon.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/ModemManager.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/man-db.timer 2>/dev/null || true

if [ -f "$1/etc/systemd/logind.conf" ]; then
  sed -i \
    -e 's/^[[:space:]]*#\?[[:space:]]*NAutoVTs=.*/NAutoVTs=1/' \
    -e 's/^[[:space:]]*#\?[[:space:]]*ReserveVT=.*/ReserveVT=1/' \
    "$1/etc/systemd/logind.conf"
fi

FSTAB="$1/etc/fstab"

sed -Ei '
  /^\s*#/b
  /^\s*$/b
  /(^|,|\s)fastboot(,|\s|$)/b
  s/^(\S+[[:space:]]+\S+[[:space:]]+\S+[[:space:]]+)(\S+)/\1\2,fastboot/
' "$FSTAB"

chmod -R 755 "$1/opt/app"
chmod +x "$1/usr/sbin/eeprom-clean.sh"

# APP="/usr/bin/chromium-browser http://127.0.0.1:3610 \
# --kiosk --noerrdialogs --disable-translate --touch-events --disable-touch-drag-drop \
# --disable-infobars --no-first-run --disable-first-run-ui --disable-pinch --overscroll-history-navigation=disabled \
# --disable-features=TouchpadOverscrollHistoryNavigation --disable-restore-session-state --ozone-platform=wayland \
# --allow-insecure-localhost --app-auto-launched --disable-extensions --disable-logging --disable-pull-to-refresh-effect --no-default-browser-check --disable-plugins \
# --disable-default-apps --disable-background-timer-throttling --disable-background-networking --disable-notifications --disable-single-click-autofill \
# --enable-features=OverlayScrollbar --start-maximized --no-sandbox --disable-crash-reporter --no-crashpad"

# sed -i \
# -e "s|<KIOSK_USER>|$IGconf_device_user1|g" \
# -e "s|<KIOSK_RUNDIR>|\/home\/$IGconf_device_user1|g" \
# -e "s|<KIOSK_APP>|$APP|g" \
# $1/etc/systemd/system/kiosk.service

# $BDEBSTRAP_HOOKS/enable-units "$1" kiosk
# $BDEBSTRAP_HOOKS/enable-units "$1" ballot-back
