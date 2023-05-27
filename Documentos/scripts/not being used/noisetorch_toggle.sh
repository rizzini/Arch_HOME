#!/bin/bash
if /usr/bin/pactl list sources | /usr/bin/grep -q 'Noise'; then
    if /usr/bin/noisetorch -u; then
        /usr/bin/echo '{PlasmoidIconStart}/home/lucas/Documentos/scripts/noisetorch_disabled.png{PlasmoidIconEnd}';
    fi
else
    if /usr/bin/noisetorch -i 'alsa_input.usb-Generic_USB2.0_PC_CAMERA-02.pro-input-0'; then
        /usr/bin/echo '{PlasmoidIconStart}/home/lucas/Documentos/scripts/noisetorch_enabled.png{PlasmoidIconEnd}';
        /usr/bin/sleep 0.5;
        /usr/bin/pactl set-default-source 'NoiseTorch Microphone for USB2.0 PC CAMERA'
    fi
fi
