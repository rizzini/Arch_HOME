#!/bin/bash
regex='(https?)://[-[:alnum:]\+&@#/%?=~_|!:,.;]*[-[:alnum:]\+&@#/%=~_|]'
baixar() {
            yt-dlp -N 10 --no-part -f "bestvsideo[height<=?1080]+bestaudio/best" "$url" -o "/mnt/hdd/Videos/xxx/new/%(title).200B.%(ext)s(ext)s" &> /dev/null
            if [ $? -eq 1 ]; then
                /usr/bin/notify-send 'URL nao suportado' -t 2000 &
                echo "$url" | tee -a /home/lucas/error.txt
                /usr/bin/xdg-open "$url" &> /dev/null & disown
            fi
}
while :; do
    existe='0'
    url="$(xsel -b)"
    if [[ "$url"  =~ $regex ]]; then
        if ! grep -q "$url" "/home/lucas/Documentos/scripts/download_videos_terminal.db"; then
            echo "$url" | tee -a /home/lucas/Documentos/scripts/download_videos_terminal.db &> /dev/null
            echo 'baixando.. '
            play /usr/share/sounds/uget/notification.wav  &> /dev/null &
            baixar &
        fi
    fi
    sleep 0.5
done


