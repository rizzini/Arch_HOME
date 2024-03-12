#!/bin/bash
export LANG=C LC_ALL=C;
{ sudo evtest /dev/input/event4 | grep --line-buffered  -Ew '\(BTN_LEFT\), value 0|\(BTN_LEFT\), value 1' | while read -r line_mouse; do
    if [ "$(xdotool getactivewindow getwindowname)" == 'Diablo IV' ]; then
        if [[ "$line_mouse" == *"value 1"* ]]; then
            touch /tmp/mouse
        else
            rm /tmp/mouse
        fi
    fi
done } &

{ xinput --test 11 | grep --line-buffered -E 'key press   50|key release 50' | while read -r line_keyboard; do
    if [ "$(xdotool getactivewindow getwindowname)" == 'Diablo IV' ]; then
        if [ "$line_keyboard" == 'key press   50' ]; then
            touch /tmp/keyboard
        else
            rm /tmp/keyboard
        fi
    fi
done } &

while :; do
    while [[ -f '/tmp/keyboard' && -f '/tmp/mouse' ]]; do
        xdotool click 1 &
        sleep 0.04
    done
    sleep 0.1
done


