    #!/bin/bash
if [ "$(systemctl is-active waydroid-container.service)" == 'active' ] || lsns | grep -E 'android|lineageos';then
    sudo systemctl stop waydroid-container.service;
    sudo pkill --cgroup=/lxc.payload.waydroid2;
    sudo killall -9 lxc-start;
    killall -9 weston;
else
    sudo systemctl start waydroid-container.service;
    weston --width=1024 --height=768 --xwayland &
        sleep 1;
    alacritty -e bash -c 'WAYLAND_DISPLAY='wayland-1' XDG_SESSION_TYPE="wayland"  DISPLAY=':1' /usr/bin/waydroid session start' &
    while ! adb connect 192.168.240.112; do
        sleep 1
    done
    scrcpy
fi
