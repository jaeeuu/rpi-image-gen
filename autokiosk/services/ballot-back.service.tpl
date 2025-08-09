[Unit]
Description=front
After=multi-user.target

[Service]
Restart=always
WorkingDirectory=/opt/app
ExecStart=/opt/app/ballot-back
StandardError=journal
LimitNOFILE=65535
MemoryMax=unlimited

[Install]
WantedBy=multi-user.target
