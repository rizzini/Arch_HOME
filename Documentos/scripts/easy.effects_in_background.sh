#!/bin/bash
if [ "$(/usr/bin/pgrep easyeffects)" ];then
    /usr/bin/pkill easyeffects;
else
    /usr/bin/easyeffects --gapplication-service &
    /usr/bin/sleep 1
    /usr/bin/easyeffects -l 'LoudnessEqualizer'
fi
