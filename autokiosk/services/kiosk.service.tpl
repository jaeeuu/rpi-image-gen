[Unit]
Description=Kiosk Wayland Session
After=seatd.service

[Service]
User=<KIOSK_USER>
Environment="XDG_RUNTIME_DIR=<KIOSK_RUNDIR>"
Environment="WLR_NO_IDLE=1"
Restart=always
ExecStart=/usr/bin/cage -- <KIOSK_APP>
StandardError=journal

[Install]
WantedBy=graphical.target
