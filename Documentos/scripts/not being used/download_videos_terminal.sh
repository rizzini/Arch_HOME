#!/bin/bash
# xdotool key ctrl+c
url=$(wl-paste)
# echo "$(tput setaf 82)URL: "$url"$(tput sgr0)"
# regex='^https?://[^/]+'
 if ! yt-dlp -f "bestvsideo[height<=?720]+bestaudio/best" "$url" -o "/mnt/hdd/Videos/%(title).200B.%(ext)s"  &> /dev/null; then
     /usr/bin/notify-send 'URL nao suportado' -t 2000;
 else
     /usr/bin/notify-send 'ok' -t 2000;
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


