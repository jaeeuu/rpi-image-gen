---
name: user-credentials
mmdebstrap:
  packages:
    - sudo
  customize-hooks:
    - chroot $1 sh -c "if ! id -u $IGconf_device_user1 >/dev/null 2>&1; then useradd --create-home --user-group --comment \"\" $IGconf_device_user1; fi"
    - chroot $1 sh -c "if ! id -u service_user >/dev/null 2>&1; then useradd -r -m -d /var/lib/service_user -s /usr/sbin/nologin service_user; fi"
    - if [ -n \"$IGconf_device_user1pass\" ]; then chroot $1 sh -c \"echo $IGconf_device_user1:$IGconf_device_user1pass | chpasswd\"; fi
    - chroot $1 sh -c \"for GRP in input spi i2c gpio render; do groupadd -f -r \$GRP; done\"
    - chroot $1 sh -c \"for GRP in adm dialout cdrom audio users sudo video games plugdev input spi i2c gpio render; do usermod -aG \$GRP $IGconf_device_user1; done\"
    - chroot $1 sh -c \"for GRP in adm dialout cdrom audio users sudo video games plugdev input spi i2c gpio render; do usermod -aG \$GRP service_user; done\"
    - chroot $1 usermod --password \"$IGconf_device_user1pass\" root
    - sed "s/^pi /$IGconf_device_user1 /" $RPI_TEMPLATES/sudo/010_pi-nopasswd > $1/etc/sudoers.d/010_pi-nopasswd
    - mkdir -p $1/etc/profile.d
    - |-
      cat <<- 'EOCHROOT' > $1/etc/profile.d/01local.sh
      #!/bin/sh
      if [ "$(id -u)" -ne 0 ]; then
        PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games
      fi
      EOCHROOT
