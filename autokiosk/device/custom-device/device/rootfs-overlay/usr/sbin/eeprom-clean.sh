#!/bin/bash

BOOTDIR="/boot/firmware"
UPD="$BOOTDIR/pieeprom.upd"
SIG="$BOOTDIR/pieeprom.sig"

[[ -e "$UPD" || -e "$SIG" ]] || exit 0

# vcgencmd bootloader_version | grep -q "$(date +%Y)" || {
#     echo "EEPROM not updated yet."
#     exit 0
# }

rm -f "$UPD" "$SIG"

systemctl disable eeprom-clean.service
ln -sf /dev/null $1/etc/systemd/system/eeprom-clean.service 2>/dev/null || true

exit 0
