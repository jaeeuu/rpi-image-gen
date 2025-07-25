[Unit]
Description=front
After=multi-user.target

[Service]
Restart=always
WorkingDirectory=/opt/app
ExecStart=/opt/app/ballot-back
StandardError=journal

[Install]
WantedBy=multi-user.target
