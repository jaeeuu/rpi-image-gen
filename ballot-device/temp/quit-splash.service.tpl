[Unit]
Description=Terminate Plymouth
After=kiosk.service rc-local.service plymouth-start.service

[Service]
ExecStart=-/usr/bin/plymouth quit --retain-splash
Type=oneshot
RemainAfterExit=yes
TimeoutSec=10
