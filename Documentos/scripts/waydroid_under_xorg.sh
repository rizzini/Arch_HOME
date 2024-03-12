#!/bin/bash
if [ "$(systemctl is-active waydroid-container.service)" == 'active' ] || lsns | grep -E 'android|lineageos';then
    killall -9 cage &> /dev/null;
    sudo systemctl stop waydroid-container.service;
    sudo pkill --cgroup=/lxc.payload.waydroid;
    exit;
fi
killall -9 cage &> /dev/null;
sudo systemctl restart waydroid-container.service;
sleep 1;
cage -d /usr/bin/waydroid show-full-ui
while pgrep "cage";do
    sleep 2;
done
sudo systemctl stop waydroid-container.service;
sudo pkill --cgroup=/lxc.payload.waydroid;
