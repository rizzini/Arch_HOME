#!/bin/bash
if [ "$(systemctl is-active waydroid-container.service)" == 'active' ];then
    killall -9 weston &> /dev/null;
    sudo systemctl stop waydroid-container.service;
    exit
fi
killall -9 weston &> /dev/null;
sudo systemctl restart waydroid-container.service;
if ! pgrep weston; then
    weston &> /dev/null &
fi
sleep 2;
export DISPLAY=':1'
export XDG_SESSION_TYPE="wayland";
alacritty -e /bin/bash -c '/usr/bin/waydroid show-full-ui' &> /dev/null &
while pgrep "weston";do
    sleep 2;
done
sudo systemctl stop waydroid-container.service;
