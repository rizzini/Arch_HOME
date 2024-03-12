#!/bin/bash
export LANG=C LC_ALL=C;
device_id=$(/usr/bin/xinput --list | /bin/grep '2.4G Mouse' |  /usr/bin/awk '{print $5}' | /usr/bin/tr -d 'id=')
/usr/bin/xinput --test "$device_id" | /bin/grep --line-buffered -E 'button press   1|button press   3|button release 1|button release 3|button press   4|button press   5' | while read -r line; do
    window=$(/usr/bin/xdotool getactivewindow getwindowname)
    if [[ "$window" == *"Netflix"* || "$window" == *"Prime Video"* ]];then
        if [ "$line" == 'button press   4' ];then
            /usr/bin/qdbus org.kde.kglobalaccel /component/kmix invokeShortcut "increase_volume"
        elif [ "$line" == 'button press   5' ];then
            /usr/bin/qdbus org.kde.kglobalaccel /component/kmix invokeShortcut "decrease_volume"
        fi
    else
        if [ "$line" == 'button press   1' ] && [ "$right_button" == 0 ];then
            left_button=1
            continue
        elif [ "$line" == 'button release 1' ]; then
            left_button=0
        fi
        if [ "$line" == 'button press   3' ] && [ "$left_button" == 1 ];then
            /home/lucas/Documentos/scripts/playerctl 'avancar_posicao'
        fi
        if [ "$line" == 'button press   3' ]; then
            right_button=1
            continue
        elif [ "$line" == 'button release 3' ]; then
            right_button=0
        fi
        if [ "$line" == 'button press   1' ] && [ "$right_button" == 1 ];then
            /home/lucas/Documentos/scripts/playerctl 'voltar_posicao'
        fi
    fi
done
