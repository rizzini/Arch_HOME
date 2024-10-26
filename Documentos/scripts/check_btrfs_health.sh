#!/bin/bash
if [ "$EUID" -ne 0 ]; then
    echo "No root, no deal..";
    exit;
fi
if test -e "/tmp/check_btrfs_health.sh.tmp"; then
    exit;
fi
touch "/tmp/check_btrfs_health.sh.tmp";
if [ ! -f /home/lucas/Documentos/scripts/check_btrfs_health.sh.db ]; then
    btrfs device stats /mnt/archlinux/ | head -2 | tail -1 |  awk '{print $2}' | tee /home/lucas/Documentos/scripts/check_btrfs_health.sh.db;
fi
err=$(btrfs device stats /mnt/archlinux/ | head -2 | tail -1 |  awk '{print $2}');
err_last=$(cat /home/lucas/Documentos/scripts/check_btrfs_health.sh.db);
if [ $err != $err_last ];then
    machinectl shell --uid=lucas .host /usr/bin/notify-send -u critical "Erro de E/S.";
    echo "$err" | tee /home/lucas/Documentos/scripts/check_btrfs_health.sh.db;
fi
rm -f "/tmp/check_btrfs_health.sh.tmp";
