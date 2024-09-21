    #!/bin/bash
if [ "$(systemctl is-active waydroid-container.service)" == 'active' ] || lsns | grep -E 'android|lineageos';then
    sudo systemctl stop waydroid-container.service;
    sudo pkill --cgroup=/lxc.payload.waydroid2;
    sudo killall -9 lxc-start;
    killall -9 weston;
else
    sudo systemctl start waydroid-container.service;
    weston --width=1024 --height=768 --xwayland &
    export WAYLAND_DISPLAY='wayland-1';
    export XDG_SESSION_TYPE="wayland";
    export DISPLAY=':1';
    sleep 1;
    alacritty -e bash -c '/usr/bin/waydroid show-full-ui';
    sudo systemctl stop waydroid-container.service;
    sudo pkill --cgroup=/lxc.payload.waydroid2;
    sudo killall -9 lxc-start;
    killall -9 weston;
fi
