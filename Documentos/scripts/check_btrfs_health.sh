#!/bin/bash
if [ "$EUID" -ne 0 ]; then
    /bin/echo "No root, no deal..";
    exit;
fi
if test -e "/tmp/check_btrfs_health.sh.tmp"; then
    exit;
fi
/usr/bin/touch "/tmp/check_btrfs_health.sh.tmp";
for path in $(/bin/mount | /bin/grep btrfs | /usr/bin/awk '{print $3}'); do
    if ! /sbin/btrfs device stats $path >> /tmp/check_btrfs_health.sh; then
        /bin/machinectl shell --uid=lucas .host /usr/bin/notify-send -u critical "Erro de E/S: "$path"";
    fi
done
/bin/rm -f "/tmp/check_btrfs_health.sh.tmp";
