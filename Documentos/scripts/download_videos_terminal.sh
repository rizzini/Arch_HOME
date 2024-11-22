#!/bin/bash
gui="$(loginctl show-session $(awk '/tty/ {print $1}' <(loginctl)) -p Type | awk -F= '{print $2}')";
    url=$(xclip -o | egrep -o 'https?://[^ ]+');

if ! yt-dlp -N 10 -f "bestvsideo[height<=?1080]+bestaudio/best" "$url" -o "/mnt/hdd/Videos/xxx/new/%(title).200B.%(ext)s(ext)s"  &> /dev/null; then
    /usr/bin/notify-send 'URL nao suportado' -t 2000;
else
#     /usr/bin/notify-send 'ok' -t 5000;
    echo 'ok'
fi
