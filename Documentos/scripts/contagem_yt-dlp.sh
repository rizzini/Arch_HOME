#!/bin/bash

while :; do
    clear

    a="$(ps aux | grep '/usr/bin/yt-dlp' | grep -v grep | wc -l)"
    printf "\r'"$a"";
    sleep 1
done
