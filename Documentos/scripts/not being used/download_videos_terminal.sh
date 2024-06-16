#!/bin/bash
# xdotool key ctrl+c
url=$(/usr/bin/xclip -o -selection clipboard)
# echo "$(tput setaf 82)URL: "$url"$(tput sgr0)"
# regex='^https?://[^/]+'
 yt-dlp -f "bestvsideo[height<=?720]+bestaudio/best" "$url" -o "/mnt/hdd/Videos/%(title).200B.%(ext)s"  &> /dev/null & disown
# if [[ $url =~ $regex ]];then
#     if ! /usr/bin/yt-dlp "$url"; then
#         if [[ "$url" == *"reddit.com/r/"* ]];then
#             /usr/bin/xdg-open "https://redditsave.com/info?url=$url" &> /dev/null & disown
#         fi
#     fi
# else
#     /bin/echo "$(tput setaf 197)URL inválido..$(tput sgr0)"
# fi


