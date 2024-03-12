#!/bin/bash
/bin/rm -f /tmp/clean_space_emergency.log
if [ "$EUID" -ne 0 ];then
    /usr/bin/echo "No root, no way.." | tee -a /tmp/clean_space_emergency.log;
    exit 1;
fi
if [ "$1" == 'force' ];then
    /bin/rm -f /tmp/clean_space_emergency.sh.lock;
    if [[ -n "$2" && "$2" != 'allhdd' && "$2" != 'allssd' ]];then
        echo 'O segundo argumento, se existir, deve ser "allssd" ou "allhdd"' | tee -a /tmp/clean_space_emergency.log;
        exit 1;
    fi
elif [[ -n "$1" && "$1" != 'force' ]];then
    echo 'O primeiro argumento, se existir, deve ser "force"' | tee -a /tmp/clean_space_emergency.log;
    exit 1;
fi
if test -e "/tmp/clean_space_emergency.sh.lock";then
    exit 1;
fi
/usr/bin/touch /tmp/clean_space_emergency.sh.lock;
if [[ "$(/bin/df -B MB  /dev/sda2 --output=avail | /usr/bin/tail -1 | /usr/bin/tr -d 'MB')" -le 700 || "$1" == 'force' && "$2" != 'allhdd' ]];then
    out_of_space=1;
    if [ "$2" == 'allssd' ];then
        /sbin/btrfs sub del /mnt/archlinux/@.snapshots/@home/* | tee -a /tmp/clean_space_emergency.log;
        /sbin/btrfs sub del /mnt/archlinux/@.snapshots/@/* | tee -a /tmp/clean_space_emergency.log;
        /sbin/btrfs sub del /mnt/archlinux/@.snapshots/@esp/* | tee -a /tmp/clean_space_emergency.log;
        /sbin/btrfs sub del /mnt/archlinux/.refind_btrfs_rw_snapshots/* | tee -a /tmp/clean_space_emergency.log;
    else
        while IFS= read -r d;do
            if [[ -d "$d" && "$d" != *"$(/sbin/btrfs subvol list / | /bin/grep HOME | /usr/bin/awk '{print $9}' | /usr/bin/tail -1)"* ]];then
                /sbin/btrfs sub del "$d";
            fi
        done < <(/usr/bin/find /mnt/archlinux/@.snapshots/@home/ -prune -type d) | tee -a /tmp/clean_space_emergency.log
        while IFS= read -r d;do
            if [[ -d "$d" && "$d" != *"$(/sbin/btrfs subvol list / | /bin/grep ROOT | /usr/bin/awk '{print $9}' | /usr/bin/tail -1)"* ]];then
                /sbin/btrfs sub del "$d";
            fi
        done < <(/usr/bin/find /mnt/archlinux/@.snapshots/@/ -prune -type d) | tee -a /tmp/clean_space_emergency.log
        while IFS= read -r d;do
            if [[ -d "$d" && "$d" != *"$(/sbin/btrfs subvol list / | /bin/grep BOOT_ESP | /usr/bin/awk '{print $9}' | /usr/bin/tail -1)"* ]];then
                /sbin/btrfs sub del "$d";
            fi
        done < <(/usr/bin/find /mnt/archlinux/@.snapshots/@esp/ -prune -type d) | tee -a /tmp/clean_space_emergency.log
        while IFS= read -r d;do
            if [[ -d "$d" && "$d" != *"$(/sbin/btrfs subvol list / | /bin/grep refind_btrfs_rw_snapshots | /usr/bin/awk '{print $9}' | /usr/bin/tail -1)"* ]]; then
                /sbin/btrfs sub del "$d";
            fi
        done < <(/usr/bin/find /mnt/archlinux/.refind_btrfs_rw_snapshots/ -prune -type d) | tee -a /tmp/clean_space_emergency.log
        if [ "$1" == 'force' ]; then
            echo -e 'Pasta \033[1m/mnt/archlinux/temp_stuff\033[0m'
            ls -lah /mnt/archlinux/temp_stuff/
            echo -e '\033[1mRemover temp_stuff?\033[0m'
            read -r temp_stuff
            if [ "$temp_stuff" == 's' ];then
                /bin/rm -rf /mnt/archlinux/temp_stuff/* | tee -a /tmp/clean_space_emergency.log;
            fi
        fi
        if [ -z "$(/usr/bin/pgrep winetricks)" ];then
            /bin/rm -rf /home/lucas/.cache/winetricks/* | tee -a /tmp/clean_space_emergency.log;
        fi
    fi
fi
if [[ "$(/bin/df -B MB  "$(/bin/mount | /bin/grep  '/mnt/backup' | /usr/bin/awk '{print $1}')" --output=avail | /usr/bin/tail -1 | /usr/bin/tr -d 'MB')" -le 700 || "$1" == 'force' && "$2" != 'allssd' ]];then
    out_of_space=1;
    /usr/bin/killall -9 btrbk_ btrbk;
    if [ "$2" == 'allhdd' ];then
        /sbin/btrfs sub del /mnt/backup/@home/* | tee -a /tmp/clean_space_emergency.log;
        /sbin/btrfs sub del /mnt/backup/@/* | tee -a /tmp/clean_space_emergency.log;
        /sbin/btrfs sub del /mnt/backup/@esp/* | tee -a /tmp/clean_space_emergency.log;
    else
        while IFS= read -r d;do
            if [[ -d "$d" && "$d" != *"$(/sbin/btrfs subvol list /mnt/backup/ROOT/ | /bin/grep ROOT | /usr/bin/awk '{print $9}' | /usr/bin/tail -1)"* ]];then
                /sbin/btrfs sub del "$d";
            fi
        done < <(/usr/bin/find /mnt/backup/ROOT/* -prune -type d) | tee -a /tmp/clean_space_emergency.log
        while IFS= read -r d;do
            if [[ -d "$d" && "$d" != *"$(/sbin/btrfs subvol list /mnt/backup/HOME/ | /bin/grep HOME | /usr/bin/awk '{print $9}' | /usr/bin/tail -1)"* ]];then
                /sbin/btrfs sub del "$d";
            fi
        done < <(/usr/bin/find /mnt/backup/HOME/* -prune -type d) | tee -a /tmp/clean_space_emergency.log
        while IFS= read -r d;do
            if [[ -d "$d" && "$d" != *"$(/sbin/btrfs subvol list /mnt/backup/BOOT_ESP/ | /bin/grep BOOT_ESP | /usr/bin/awk '{print $9}' | /usr/bin/tail -1)"* ]];then
                /sbin/btrfs sub del "$d";
            fi
        done < <(/usr/bin/find /mnt/backup/BOOT_ESP/* -prune -type d) | tee -a /tmp/clean_space_emergency.log
    fi
fi
if [[ -n "$out_of_space" && "$1" != 'force' ]];then
    /bin/machinectl shell --uid=lucas .host /usr/bin/notify-send -u critical "Script clean_space_emergency.sh executado. Checar logs em /tmp/clean_space_emergency.sh.log." &> /dev/null;
fi
