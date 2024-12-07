#!/bin/bash
counter=0
regex='(https?)://[-[:alnum:]\+&@#/%?=~_|!:,.;]*[-[:alnum:]\+&@#/%=~_|]'
baixar() {
            cd /mnt/hdd/Videos/xxx/new/
            yt-dlp -P "temp:tmp" -N 10 -f "bestvsideo[height<=?1080]+bestaudio/best" "$url" &> /dev/null
            if [ $? -eq 1 ]; then
                /usr/bin/notify-send 'URL nao suportado' -t 2000 &
                echo "$url" | tee -a /home/lucas/error.txt &> /dev/null
                /usr/bin/xdg-open "$url" &> /dev/null & disown
            fi
}
while :; do
    counter=$((counter + 1))
    existe='0'
    url="$(timeout 1 xsel -b)"
    if [[ "$url"  =~ $regex && $(wc -l <<< "$url") -eq 1 ]]; then
        if ! grep -q "$url" "/home/lucas/Documentos/scripts/download_videos_terminal.db"; then
            echo "$url" | tee -a /home/lucas/Documentos/scripts/download_videos_terminal.db &> /dev/null
#             echo 'baixando.. '
            play /usr/share/sounds/uget/notification.wav  &> /dev/null &
            baixar &
        fi
    fi
    sleep 0.5
    if [ $((counter%2)) -eq 0 ]; then
        printf "\r                  $(ps aux | grep '/usr/bin/yt-dlp' | grep -v grep | wc -l)"
    fi
    if [ $counter -ge 10  ]; then
        counter=0
    fi
done

