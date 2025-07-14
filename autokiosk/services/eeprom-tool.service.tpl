[Unit]
Description=One-time cleanup of pieeprom update files
ConditionPathExists=/boot/firmware/pieeprom.upd
After=default.target

[Service]
Type=oneshot
ExecStart=/usr/sbin/eeprom-tool.sh

[Install]
WantedBy=default.target
