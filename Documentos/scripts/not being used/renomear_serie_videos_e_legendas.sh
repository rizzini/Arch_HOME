#!/bin/bash
files=$(/usr/bin/find "$PWD" -type f);
if [[ ! "$files" ==  *'1.srt'* && "$files" ==  *'srt'* ]]; then
    /usr/bin/find "$PWD" -type f -iname "*.srt" | /usr/bin/sort;
    /bin/echo "Começar a partir de qual número?";
    read -r numero_srt;
    /usr/bin/find "$PWD" -iname "*.srt" -type f | /usr/bin/sort | /usr/bin/gawk 'BEGIN{ a="'"$numero_srt"'" }{ printf "/bin/mv '\''%s'\'' %01d.srt\n", $0, a++ }';
    /bin/echo "Renomear legendas? S ou N: ";
    read -r pergunta_legenda;
    if [[ "${pergunta_legenda,,}" == 's' || "${pergunta_legenda^^}" == 'S' ]];then
        if /usr/bin/find "$PWD" -iname "*.srt" -type f | /usr/bin/sort | /usr/bin/gawk 'BEGIN{ a="'"$numero_srt"'" }{ printf "/bin/mv '\''%s'\'' %01d.srt\n", $0, a++ }' | /bin/bash; then
            /bin/echo "legendas renomeadas..";
        else
            /bin/echo 'legendas não renomeadas..';
        fi
    fi
else
    /bin/echo 'não possui legendas ou já foram renomeadas..';
fi
if [[ ! "$files" == *'1.mkv'* && "$files" ==  *'mkv'* ]]; then
    /usr/bin/find "$PWD" -type f -iname "*.mkv" | /usr/bin/sort;
    /bin/echo "Começar a partir de qual número?";
    read -r numero_mkv;
    /usr/bin/find "$PWD" -iname "*.mkv" -type f | /usr/bin/sort | /usr/bin/gawk 'BEGIN{ a="'"$numero_mkv"'" }{ printf "/bin/mv '\''%s'\'' %01d.mkv\n", $0, a++ }';
    /bin/echo "Renomear vídeos? S ou N: ";
    read -r pergunta_mkv;
    if [[ "${pergunta_mkv,,}" == 's' || "${pergunta_mkv^^}" == 'S' ]];then
        /usr/bin/find "$PWD" -iname "*.mkv" -type f | /usr/bin/sort | /usr/bin/gawk 'BEGIN{ a="'"$numero_mkv"'" }{ printf "/bin/mv '\''%s'\'' %01d.mkv\n", $0, a++ }' | /bin/bash;
        /bin/echo "vídeos renomeados..";
    else
        /bin/echo 'vídeos não renomeados..';
    fi
elif [[ ! "$files" == *'1.mp4'* && "$files" ==  *'mp4'* ]]; then
    /usr/bin/find "$PWD" -type f -iname "*.mp4" | /usr/bin/sort;
    /bin/echo "Começar a partir de qual número?";
    read -r numero_mp4;
    /usr/bin/find "$PWD" -iname "*.mp4" -type f | /usr/bin/sort | /usr/bin/gawk 'BEGIN{ a="'"$numero_mp4"'" }{ printf "/bin/mv '\''%s'\'' %01d.mp4\n", $0, a++ }';
    /bin/echo "Renomear vídeos? S ou N: ";
    read -r pergunta_mp4;
    if [[ "${pergunta_mp4,,}" == 's' || "${pergunta_mp4^^}" == 'S' ]];then
        /usr/bin/find "$PWD" -iname "*.mp4" -type f | /usr/bin/sort | /usr/bin/gawk 'BEGIN{ a="'"$numero_mp4"'" }{ printf "/bin/mv '\''%s'\'' %01d.mp4\n", $0, a++ }' | /bin/bash;
        /bin/echo "vídeos renomeados..";
    else
        /bin/echo 'vídeos não renomeados..';
    fi
else
    /bin/echo 'não possui vídeos ou já foram renomeados..';
fi
