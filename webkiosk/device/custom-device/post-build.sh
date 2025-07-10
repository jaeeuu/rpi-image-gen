#!/bin/sh

set -eu

rootfs="$1"

# ------ disable display blanking ---------------------------
install -D -m644 /usr/share/wayfire/wayfire.ini \
                 "$1/etc/xdg/wayfire/wayfire.ini"
sed -i '/^\[idle\]/,/^\[/{/dpms_timeout/ s/=.*/=-1/; /screensaver_timeout/ s/=.*/=-1/; /disable_initially/ s/=.*/=true/}' \
    "$1/etc/xdg/wayfire/wayfire.ini"
#echo 'consoleblank=0' >> "${BOOTFS_DIR}/cmdline.txt"

# ------ EEPROM tweaks --------------------------------------
cat >> "$1/etc/rc.local" <<'EOF'
/usr/bin/rpi-eeprom-config --edit <<EOC
[all]
WAIT_FOR_POWER_BUTTON=0
POWER_OFF_ON_HALT=0
EOC
exit 0    # keep rc.local happy
EOF
