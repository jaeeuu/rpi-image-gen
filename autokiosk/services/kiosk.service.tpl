[Unit]
Description=Kiosk Wayland Session
After=multi-user.target

[Service]
User=<KIOSK_USER>
TTYPath=/dev/tty1
Environment="XDG_RUNTIME_DIR=<KIOSK_RUNDIR>"
Environment="WLR_NO_IDLE=1"
Restart=always
RestartPreventExitStatus=0
ExecStart=/usr/bin/cage -- <KIOSK_APP>
StandardError=journal

[Install]
WantedBy=multi-user.target
