#!/usr/bin/env bash
set -eu

MOUNT_POINT="/dev/usbdrive"

ACTION="$1"
DEVNODE="$2"

is_mounted() { mountpoint -q "$MOUNT_POINT"; }

log() { logger -t usb_auto_mount "$*"; }

case "$ACTION" in
  add)
    is_mounted && exit 0

    mkdir -p "$MOUNT_POINT"
    if mount -o rw,relatime "$DEVNODE" "$MOUNT_POINT"; then
      log "mounted $DEVNODE -> $MOUNT_POINT"
    else
      log "failed to mount $DEVNODE"
      rmdir "$MOUNT_POINT" 2>/dev/null || true
    fi
    ;;

  remove)
    if is_mounted; then
      CUR_SRC=$(findmnt -n -o SOURCE "$MOUNT_POINT")
      if [ "$CUR_SRC" = "$DEVNODE" ]; then
        umount "$MOUNT_POINT" && log "unmounted $DEVNODE"
        rmdir "$MOUNT_POINT" 2>/dev/null || true
      fi
    fi
    ;;
esac
exit 0
