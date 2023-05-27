#!/bin/bash
export LANG=C LC_ALL=C;
/usr/bin/ibus-ui-emojier-plasma &
/usr/bin/sleep 1
while [ "$(/usr/bin/xdotool getactivewindow getwindowclassname)" == "plasma.emojier" ]; do
    /usr/bin/sleep 0.5;
done
/usr/bin/killall ibus-ui-emojier-plasma
