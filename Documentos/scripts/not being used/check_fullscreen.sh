#!/bin/bash
sleep 10
    while :;do
    WINDOW=$(echo $(xwininfo -id $(xdotool getactivewindow) -stats | grep -E '(Width|Height):' | awk '{print $NF}') | sed -e 's/ /x/')
    SCREEN=$(xdpyinfo | grep -m1 dimensions | awk '{print $2}')
    if [ "$WINDOW" = "$SCREEN" ] && [[ "$(xwininfo -id $(xdotool getactivewindow) -stats)" != *"Área de trabalho"*  ]]; then
        touch /tmp/fullscreen
        killall -9 radeontop
    else
        rm -f /tmp/fullscreen
        if ! pgrep radeontop &> /dev/null; then
            radeontop -d /tmp/1 &> /dev/null & disown
        fi
    fi
    sleep 4
done
