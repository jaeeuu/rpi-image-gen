[Unit]
Description=backend

[Service]
Restart=always
RestartSec=5
WorkingDirectory=/opt/app
ExecStart=/opt/app/back
StandardError=journal

[Install]
WantedBy=multi-user.target
