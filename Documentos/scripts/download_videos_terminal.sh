#!/bin/bash
xclip -sel clip < /dev/null;
export LC_ALL=C;
counter=0;
regex='(https|http?)://[-[:alnum:]\+&@#/%?=~_|!:,.;]*[-[:alnum:]\+&@#/%=~_|]';
baixar() {
            cd /mnt/hdd/Videos/xxx/new/
            if [[ "$url" == *"spankbang"* ]]; then
                /usr/bin/notify-send 'URL nao suportado' -t 2000 &
                echo "$url" | tee -a /home/lucas/error.txt &> /dev/null;
                /usr/bin/xdg-open "$url" &> /dev/null & disown;
                exit;
            fi
            yt-dlp -P "temp:tmp" -f "bestvsideo[height<=?1080]+bestaudio/best" "$url" &> /dev/null;
            if [ $? -eq 1 ]; then
                /usr/bin/notify-send 'URL nao suportado' -t 2000 &
                echo "$url" | tee -a /home/lucas/error.txt &> /dev/null;
                if wmctrl -l | grep 'Google Chrome'; then
                    google-chrome-stable "$url" &> /dev/null & disown;
                else
                    /usr/bin/xdg-open "$url" &> /dev/null & disown;
                fi
            fi
}
while :; do
    counter=$((counter + 1));
    existe='0';
    url="$(timeout 1 xsel -b)";
    if [[ "$url"  =~ $regex && $(wc -l <<< "$url") -eq 1 ]]; then
        if ! grep -q "$url" "/home/lucas/Documentos/scripts/download_videos_terminal.db"; then
            if [[ "$url" == *"$(cat /home/lucas/Documentos/scripts/download_videos_terminal_not_supp.db)"* ]]; then
                if ! grep -q "$url" "/home/lucas/error.txt"; then
                    echo "$url" | tee -a /home/lucas/error.txt &> /dev/null;
                    if wmctrl -l | grep 'Google Chrome'; then
                        google-chrome-stable "$url" &> /dev/null & disown;
                    else
                        /usr/bin/xdg-open "$url" &> /dev/null & disown;
                    fi
                fi
            else
                echo "$url" | tee -a /home/lucas/Documentos/scripts/download_videos_terminal.db &> /dev/null;
                play -q /usr/share/sounds/uget/notification.wav &
                baixar &
            fi
        fi
    fi
    sleep 0.5;
    if [ $((counter%2)) -eq 0 ]; then
        printf "\r                  $(ps aux | grep '/usr/bin/yt-dlp' | grep -v grep | wc -l)";
    fi
    if [ $counter -ge 10  ]; then
        counter=0;
    fi
done

