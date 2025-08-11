#!/bin/bash

BOOTFS="/boot/firmware"
SPIDEV="/dev/spidev10.0"
freq="16000"

#flashrom -p linux_spi:dev=/dev/spidev10.0,spispeed=16000 -w /boot/firmware/pieeprom.upd
# flashrom -p linux_spi:dev=${SPIDEV},spispeed=${freq} -w ${BOOTFS}/pieeprom.upd
# if ! flashrom -p "linux_spi:dev=${SPIDEV},spispeed=16000" -w "${BOOTFS}/pieeprom.upd"; then
#     flashrom -p "linux_spi:dev=${SPIDEV},spispeed=8000" -w "${BOOTFS}/pieeprom.upd"
# fi

[[ -e "$BOOTFS/pieeprom.upd" || -e "$BOOTFS/pieeprom.sig" ]] || exit 0

# vcgencmd bootloader_version | grep -q "$(date +%Y)" || {
#     echo "EEPROM not updated yet."
#     exit 0
# }

rm -f "$BOOTFS/pieeprom.upd" "$BOOTFS/pieeprom.sig"

systemctl disable eeprom-tool.service
ln -sf /dev/null $1/etc/systemd/system/eeprom-tool.service 2>/dev/null || true

exit 0
