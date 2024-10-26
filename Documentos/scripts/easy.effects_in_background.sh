#!/bin/bash
if [ "$(pgrep easyeffects)" ];then
    pkill easyeffects;
else
    easyeffects --gapplication-service & disown
fi
