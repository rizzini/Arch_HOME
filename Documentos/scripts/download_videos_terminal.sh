#!/bin/bash
gui="$(loginctl show-session $(awk '/tty/ {print $1}' <(loginctl)) -p Type | awk -F= '{print $2}')";

if [[ "$(loginctl show-session $(loginctl | grep "$USER" | awk '{print $1}') -p Type)" == *"wayland"* ]]; then
    url=$(wl-paste | egrep -o 'https?://[^ ]+');
else
    url=$(xclip -o | egrep -o 'https?://[^ ]+');
fi

if ! yt-dlp -N 10 -f "bestvsideo[height<=?1080]+bestaudio/best" "$url" -o "/mnt/hdd/Videos/xxx/new/%(title).200B.%(ext)s(ext)s"  &> /dev/null; then
    /usr/bin/notify-send 'URL nao suportado' -t 2000;
    echo "$url" | tee -a /home/lucas/error.txt
else
    echo "$url" | tee -a /home/lucas/.xxx_ok.txt
fi
