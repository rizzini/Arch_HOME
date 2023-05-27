#!/bin/bash
pulseeffects=0
spotify=0
if [ "$(/usr/bin/pgrep easyeffects)" ]; then
    pulseeffects=1
    /home/lucas/Documentos/scripts/easy.effects_in_background.sh
fi
if [ "$(/usr/bin/pgrep spotify)" ]; then
    spotify=1
    /usr/bin/pkill spotify
fi
if [ ! -h "/etc/wireplumber/main.lua.d/51-alsa-disable.lua" ];then
    get_current_volume="$(/usr/bin/pactl get-sink-volume "$(/usr/bin/pactl get-default-sink)" | /usr/bin/awk '{print $12}')";
    /usr/bin/sudo /bin/ln -sf /etc/wireplumber/main.lua.d/disable_minisystem/51-alsa-disable.lua /etc/wireplumber/main.lua.d/51-alsa-disable.lua;
    /bin/systemctl --user restart pipewire.service wireplumber.service;
    /usr/bin/sleep 1;
    /usr/bin/pactl set-sink-volume alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1 "$get_current_volume";
elif [ -h "/etc/wireplumber/main.lua.d/51-alsa-disable.lua" ]; then
    get_current_volume="$(/usr/bin/pactl get-sink-volume 'alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1' | /usr/bin/awk '{print $12}')";
    /usr/bin/sudo /bin/rm -f /etc/wireplumber/main.lua.d/51-alsa-disable.lua;
    /bin/systemctl --user restart pipewire.service wireplumber.service;
    /usr/bin/pactl load-module module-combine-sink sink_name=combination-sink sink_properties=slaves=alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1,alsa_output.pci-0000_00_1b.0.analog-stereo channels=2,bluez_output.30_21_46_33_0C_70.1
    /usr/bin/sleep 1
    /usr/bin/pactl set-default-sink combination-sink;
    for i in $(/usr/bin/pactl list sinks | /bin/grep -sw 'Nome:' | /bin/grep -e 'alsa_output.pci' | /usr/bin/cut -d ":" -f2);do
        /usr/bin/pactl set-sink-volume "$i" 100%;
    done
    /usr/bin/pactl set-sink-volume "$(/usr/bin/pactl get-default-sink)" "$get_current_volume";
    /usr/bin/pactl set-default-source 'Echo Cancellation Source'
fi
if [ $pulseeffects == 1 ];then
    /home/lucas/Documentos/scripts/easy.effects_in_background.sh
fi
if [ $spotify == 1 ];then
    /usr/bin/spotify & disown
fi
