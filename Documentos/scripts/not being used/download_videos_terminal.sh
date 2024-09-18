#!/bin/bash
# xdotool key ctrl+c

gui="$(loginctl show-session $(awk '/tty/ {print $1}' <(loginctl)) -p Type | awk -F= '{print $2}'
)"
# echo "$(tput setaf 82)URL: "$url"$(tput sgr0)"
# regex='^https?://[^/]+'
## if ! yt-dlp -f "bestvsideo[height<=?1080]+bestaudio/best" "$url" -o "/mnt/hdd/Videos/%(title).200B.%(ext)s"  &> /dev/null; then
if [ "$gui" == 'X11' ]; then
    url=$(xclip -o)
    if ! yt-dlp -f "bestvsideo[height<=?1080]+bestaudio/best" "$url" -o "/mnt/hdd/Videos/%(title).200B.%(ext)s(ext)s"  &> /dev/null; then
        /usr/bin/notify-send 'URL nao suportado' -t 2000;
    else
        /usr/bin/notify-send 'ok' -t 5000;
    fi
elif [ "$gui" == 'wayland' ]; then
    url=$(wl-paste)
    if ! yt-dlp -f "bestvsideo[height<=?1080]+bestaudio/best" "$url" -o "/mnt/hdd/Videos/%(title).200B.%(ext)s(ext)s"  &> /dev/null; then
        /usr/bin/notify-send 'URL nao suportado' -t 2000;
    else
        /usr/bin/notify-send 'ok' -t 5000;
    fi
fi
# if [[ $url =~ $regex ]];then
#     if ! /usr/bin/yt-dlp "$url"; then
#         if [[ "$url" == *"reddit.com/r/"* ]];then
#             /usr/bin/xdg-open "https://redditsave.com/info?url=$url" &> /dev/null & disown
#         fi
#     fi
# else
#     /bin/echo "$(tput setaf 197)URL inválido..$(tput sgr0)"
# fi


