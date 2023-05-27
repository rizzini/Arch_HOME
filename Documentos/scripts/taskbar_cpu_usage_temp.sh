#!/bin/bash
renice -n 19 -p $(pgrep  'taskbar_cpu')
# command='if [ "$(pgrep "htop")" ];then /usr/bin/killall htop;else /usr/bin/alacritty -o window.dimensions.lines=33 window.dimensions.columns=120 -e /usr/bin/htop;fi'
command='if [ "$(pgrep "systemmonitor")" ];then killall systemmonitor &> /dev/null;else /usr/bin/systemmonitor & disown $!;fi';
threshold=70
while :; do
    cpu_temp=$(/usr/bin/sensors | /bin/grep 'Package id 0:' | /usr/bin/tail -1 | /usr/bin/cut -c 17-18)
    cpu_usage=$(/usr/bin/awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print ($2+$4-u1) * 100 / (t-t1); }' <(/bin/grep 'cpu ' /proc/stat) <(/usr/bin/sleep 1;/bin/grep 'cpu ' /proc/stat))
    cpu_usage=${cpu_usage%.*}
    rpm=$(sensors  | grep fan2 | cut -c23-27)
    if [ $cpu_temp -ge $threshold ]; then
        DATA='| C | CPU: <b>'$cpu_usage'%</b> Temp: <b>'$cpu_temp'ºc / FAN:<b>'$rpm' RPM</b>  | Temp: <b>'$cpu_temp'ºc</b> | '$command' |'
    else
        DATA='| A | CPU: <b>'$cpu_usage'%</b> / Temp: <b>'$cpu_temp'ºc</b> / FAN:<b>'$rpm' RPM</b>  | Temp: <b>'$cpu_temp'ºc</b> | '$command' |'
    fi
    if [ "$DATA" != "$DATA_last" ];then
        /usr/bin/qdbus org.kde.plasma.doityourselfbar /id_954 org.kde.plasma.doityourselfbar.pass "$DATA"
        DATA_last="$DATA"
    fi
    /usr/bin/sleep 0.5
done
