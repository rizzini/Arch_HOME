#!/bin/bash
renice -n 19 -p $(pgrep  'taskbar_volume.')
command='$(if ! pgrep easyeffects; then /home/lucas/Documentos/scripts/easy.effects_in_background.sh; else pkill easyeffects; fi)'
while :; do
	volume=$(pactl get-sink-volume "$(pactl get-default-sink)" | awk '{print $12}');
	if [[ "$(pgrep easyeffects)" && "$(pactl get-default-sink)" == 'combination-sink' ]]; then
		DATA='| A | EF: <b>On</b>  \| Volume: <b>'$volume'</b> \| Sim: <b>On</b> | | '$command' |';
	elif [[ "$(pgrep easyeffects)" && "$(pactl get-default-sink)" != 'combination-sink' ]]; then
		DATA='| A | EF: <b>On</b>  \| Volume: <b>'$volume'</b> \| Sim: <b>Off</b> | | '$command' |';
	elif [[ ! "$(pgrep easyeffects)" && "$(pactl get-default-sink)" != 'combination-sink' ]]; then
		DATA='| A | EF: <b>Off</b>  \| Volume: <b>'$volume'</b> \| Sim: <b>Off</b> | | '$command' |';
	elif [[ ! "$(pgrep easyeffects)" && "$(pactl get-default-sink)" == 'combination-sink' ]]; then
		DATA='| A | EF: <b>Off</b>  \| Volume: <b>'$volume'</b> \| Sim: <b>On</b> | | '$command' |';
	fi
	qdbus org.kde.plasma.doityourselfbar /id_956 org.kde.plasma.doityourselfbar.pass "$DATA";
	sleep 0.5;
done


