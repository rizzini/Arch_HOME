#!/bin/bash
if [ "$(systemctl is-active waydroid-container.service)" == 'active' ] || lsns | grep -E 'android|lineageos';then
    sudo systemctl stop waydroid-container.service;
    sudo pkill --cgroup=/lxc.payload.waydroid2;
    sudo killall -9 lxc-start;
    exit;
else
    sleep 1;
    sudo systemctl restart waydroid-container.service;
    waydroid session start &> /dev/null & disown
    while ! ping -w 5 -c 1 192.168.240.112; do
        sleep 1
    done
    killall adb
    adb disconnect

    while    ! adb connect 192.168.240.112; do
        sleep 1
    done
    scrcpy & disown

fi
