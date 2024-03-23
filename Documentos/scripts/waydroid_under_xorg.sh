#!/bin/bash
if [ "$(systemctl is-active waydroid-container.service)" == 'active' ] || lsns | grep -E 'android|lineageos';then
    killall -9 weston &> /dev/null;
    sudo systemctl stop waydroid-container.service;
    sudo pkill --cgroup=/lxc.payload.waydroid;
    exit;
fi
if pgrep weston; then
    killall -9 weston;
fi
sudo systemctl restart waydroid-container.service;
sleep 1;
weston --width=480 --height=600 --xwayland &> /dev/null & disown
export WAYLAND_DISPLAY='wayland-1';
export XDG_SESSION_TYPE="wayland";
export DISPLAY=':1';
sleep 1;
alacritty -e bash -c '/usr/bin/waydroid show-full-ui'
sudo systemctl stop waydroid-container.service;
sudo pkill --cgroup=/lxc.payload.waydroid;
