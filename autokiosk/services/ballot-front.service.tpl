[Unit]
Description=front
Before=kiosk.service

[Service]
Restart=always
WorkingDirectory=/opt/app
ExecStart=/opt/app/front-serve
StandardError=journal

[Install]
WantedBy=sysinit.target
