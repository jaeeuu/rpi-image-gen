[Unit]
Description=Kiosk Wayland Session
After=seatd.service

[Service]
User=admin
RuntimeDirectory=admin
RuntimeDirectoryMode=0700
Environment=XDG_RUNTIME_DIR=%t/admin
Environment="WLR_NO_IDLE=1"
Environment="COG_MODULEDIR=/usr/lib/aarch64-linux-gnu/cog/modules"
Environment="COG_PLATFORM_NAME=drm"
Environment="COG_PLATFORM_PARAMS=renderer=gles,rotation=1"
Environment="NO_AT_BRIDGE=1"
Restart=on-failure
ExecStart=/usr/bin/cog --platform=drm --platform-params="renderer=gles,rotation=1" --dir-handler=local:/opt/app/web local:///index.html
StandardError=journal

[Install]
WantedBy=local-fs.target
