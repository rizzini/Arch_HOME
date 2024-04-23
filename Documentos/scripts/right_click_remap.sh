#!/bin/bash
device_id="$(xinput --list | grep keyboard | grep 'Microsoft Wired Keyboard 600 ' | awk '{print $6}' | tr -d 'id=' | head -1)"
if [ -n "$1" ]; then
/usr/bin/xinput --test "$1" | /bin/grep --line-buffered -E 'key press   108|key release 108' |
    while read -r line; do
        if [ "$line" == 'key press   108' ]; then
            xdotool mousedown 3 &
        elif [ "$line" == 'key release 108' ]; then
            xdotool mouseup 3 &
        fi

    done
else
/usr/bin/xinput --test "$device_id" | /bin/grep --line-buffered -E 'key press   108|key release 108' |
    while read -r line; do
        if [ "$line" == 'key press   108' ]; then
            xdotool mousedown 3 &
        elif [ "$line" == 'key release 108' ]; then
            xdotool mouseup 3 &
        fi

    done
fi
