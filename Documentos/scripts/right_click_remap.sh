#!/bin/bash
export LANG=C LC_ALL=C;
/usr/bin/xinput --test '11' | /bin/grep --line-buffered -E 'key press   108' | while read -r line; do
    if [ "$line" == 'key press   108' ] && [ "$down" != '1' ]; then
        xdotool click 3 &
    fi
done
