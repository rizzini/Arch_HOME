#!/bin/bash
notify-send "Reconhecendo música.. " -a 'Reconhecimento de música' -i /mnt/archlinux/@/usr/share/icons/breeze-dark/actions/24/music-note-16th.svg
song_exists=0
recognized_song="$(timeout 10 songrec recognize 2> /dev/null)";
if [[ -n "$recognized_song" ]]; then
    for i in /home/lucas/Musicas/*; do
        if [[ "$(echo "$i" | cut -c21-999)" == *"$recognized_song"* ]]; then
            song_exists=1;
            break;
        fi
    done
    if [ "$song_exists" == 1 ]; then
        echo 'Música já cadastrada..';
        notify-send "Música já cadastrada.." "<b>${recognized_song%%-*} - ${recognized_song#*-}</b>" -a 'Reconhecimento de música' -i /mnt/archlinux/@/usr/share/icons/breeze-dark/actions/24/music-note-16th.svg
    else
        if lyrics -t "${recognized_song#*-}" "${recognized_song%%-*}" | tee '/home/lucas/Musicas/'"$(echo $recognized_song | sed 's#/#\\#g')"''; then
            notify-send "Música reconhecida com sucesso:"  "<b>${recognized_song%%-*} - ${recognized_song#*-}</b>" -a 'Reconhecimento de música' -i /mnt/archlinux/@/usr/share/icons/breeze-dark/actions/24/music-note-16th.svg;
        else
            notify-send -u critical "Música reconhecida com sucesso, porém não foi possível baixar a letra." -i /mnt/archlinux/@/usr/share/icons/breeze-dark/actions/24/music-note-16th.svg;
        fi
    fi
else
    echo 'Música não reconhecida ou demorou muito para reconhecer..';
    notify-send "Música não reconhecida ou demorou muito para reconhecer.." -a 'Reconhecimento de música' -i /mnt/archlinux/@/usr/share/icons/breeze-dark/actions/24/music-note-16th.svg

fi
