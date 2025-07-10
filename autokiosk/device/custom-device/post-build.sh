#!/bin/sh

set -eu

# Mask unwanted services to prevent power-saving actions or delays (if present)
ln -sf /dev/null $1/etc/systemd/system/systemd-suspend.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/systemd-hibernate.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/apt-daily.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/apt-daily.timer 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/apt-daily-upgrade.service 2>/dev/null || true
ln -sf /dev/null $1/etc/systemd/system/apt-daily-upgrade.timer 2>/dev/null || true
# rootfs="$1"

# ------ disable display blanking ---------------------------

#echo 'consoleblank=0' >> "${BOOTFS_DIR}/cmdline.txt"

# ------ EEPROM tweaks --------------------------------------
# cat >> "$1/etc/rc.local" <<'EOF'
# /usr/bin/rpi-eeprom-config --edit <<EOC
# [all]
# WAIT_FOR_POWER_BUTTON=0
# POWER_OFF_ON_HALT=0
# EOC
# exit 0    # keep rc.local happy
# EOF
