[Unit]
Description=One-time cleanup of pieeprom update files
ConditionPathExists=/boot/firmware/pieeprom.upd
DefaultDependencies=no
After=local-fs.target

[Service]
Type=oneshot
ExecStart=/usr/sbin/eeprom-clean.sh

[Install]
WantedBy=multi-user.target
