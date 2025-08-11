#!/usr/bin/env bash
set -eu
PATH=/usr/sbin:/usr/bin:/sbin:/bin

MOUNT_POINT="/data/usb"
OWNER_UID=1000
OWNER_GID=1000

ACTION="${1:-}"
DEVNODE="${2:-}"

fstype_of() {
  /usr/sbin/blkid -o value -s TYPE "$1" 2>/dev/null \
    || /usr/bin/lsblk -no FSTYPE "$1" 2>/dev/null \
    || true
}

case "$ACTION" in
  add)
    if /usr/bin/mountpoint -q "$MOUNT_POINT"; then exit 0; fi
    FSTYPE="$(fstype_of "$DEVNODE")"
    [ -z "${FSTYPE:-}" ] && exit 0
    FSTYPE="${FSTYPE,,}"

    mkdir -p "$MOUNT_POINT"

    DEFAULT_OPTS="rw,relatime"
    TYPE="$FSTYPE"

    case "$FSTYPE" in
      vfat|fat|msdos)
        TYPE="vfat"
        OPTS="$DEFAULT_OPTS,iocharset=utf8,codepage=949,shortname=mixed,uid=1000,gid=1000,umask=000"
        ;;
      exfat)
        TYPE="exfat"
        OPTS="$DEFAULT_OPTS,uid=1000,gid=1000,umask=000"
        ;;
      ntfs|ntfs3|ntfs-3g)
        TYPE="ntfs3"
        OPTS="$DEFAULT_OPTS,uid=1000,gid=1000,umask=000"
        ;;
      *)
        TYPE="$FSTYPE" # ext4/xfs/btrfs
        ;;
    esac
    /usr/bin/mount -t "$TYPE" -o "$OPTS" "$DEVNODE" "$MOUNT_POINT" || true
    ;;
  remove)
    if /usr/bin/mountpoint -q "$MOUNT_POINT"; then
      CUR_SRC=$(/usr/bin/findmnt -n -o SOURCE "$MOUNT_POINT" || true)
      if [ "$CUR_SRC" = "$DEVNODE" ]; then
        /usr/bin/umount "$MOUNT_POINT" || true
        rmdir "$MOUNT_POINT" 2>/dev/null || true
      fi
    fi
    ;;
esac

exit 0
