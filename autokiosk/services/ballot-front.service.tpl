[Unit]
Description=front

[Service]
Restart=always
WorkingDirectory=/opt/app
ExecStart=/opt/app/front-serve
StandardError=journal

[Install]
WantedBy=multi-user.target
