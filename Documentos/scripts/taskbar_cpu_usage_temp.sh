#!/bin/bash
renice -n 19 -p $(pgrep  'taskbar_cpu')
command='if [ "$(pgrep "systemmonitor")" ];then killall systemmonitor &> /dev/null;else /usr/bin/systemmonitor & disown $!;fi';
threshold=78
while :; do
    cpu_temp=$(cat /sys/class/thermal/thermal_zone0/temp)
    cpu_temp=${cpu_temp:0:2}
    cpu_usage=$(awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print ($2+$4-u1) * 100 / (t-t1); }' <(grep 'cpu ' /proc/stat) <(sleep 1;grep 'cpu ' /proc/stat))
    rpm=$(cat /sys/devices/platform/nct6775.656/hwmon/hwmon1/fan2_input)
    if [ "$cpu_temp" -ge $threshold ]; then
        DATA='| C | CPU: <b>'${cpu_usage%.*}'%</b> Temp: <b>'$cpu_temp'ºc / FAN: <b>'$rpm' RPM</b>  | | '$command' |'
    else
        DATA='| A | CPU: <b>'${cpu_usage%.*}'%</b> / Temp: <b>'$cpu_temp'ºc</b> / FAN: <b>'$rpm' RPM</b>  | | '$command' |'
    fi
    if [ "$DATA" != "$DATA_last" ];then
        qdbus org.kde.plasma.doityourselfbar /id_954 org.kde.plasma.doityourselfbar.pass "$DATA"
        DATA_last="$DATA"
    fi
    sleep 0.5
done
