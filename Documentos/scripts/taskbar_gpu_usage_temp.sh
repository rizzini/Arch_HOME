#!/bin/bash
renice -n 19 -p $(pgrep  'taskbar_gpu')
if pgrep radeontop; then
    radeontop -d /tmp/1 &> /dev/null & disown
else
    killall -9 radeontop
    radeontop -d /tmp/1 &> /dev/null & disown
fi
# command='if [ "$(pgrep "htop")" ];then /usr/bin/killall htop;else /usr/bin/alacritty -o window.dimensions.lines=33 window.dimensions.columns=120 -e /usr/bin/htop;fi'
command='if [ "$(pgrep "radeontop")" ];then killall radeontop &> /dev/null;else /usr/bin/alacritty -o window.dimensions.lines=30 window.dimensions.columns=120 -e /usr/bin/radeontop -Tc & disown $!;fi';
threshold=70
while :; do
    cpu_temp=$(/usr/bin/sensors | grep 'edge:' | awk '{print $2}' | awk -F'[^0-9]*' '$0=$2')
    cpu_usage=$(cat /tmp/1 | tail -1 | awk '{print $5}\')
    rpm_gpu=$(sensors | grep 'fan1' | tail -1 | awk '{print $2}')
     if [ $rpm_gpu -eq 1444 ]; then
        DATA='| C | GPU: <b>'$(echo ${cpu_usage%,*})'</b> Temp: <b>'$cpu_temp'ºc / </b> FAN: <b>Off</b> | Temp: <b>'$cpu_temp'ºc</b> | '$command' |'
     else
         DATA='| C | GPU: <b>'$(echo ${cpu_usage%,*})'</b> Temp: <b>'$cpu_temp'ºc / </b> FAN: <b>'$rpm_gpu' RPM</b> | Temp: <b>'$cpu_temp'ºc</b> | '$command' |'
     fi
    if [ "$DATA" != "$DATA_last" ];then
        /usr/bin/qdbus org.kde.plasma.doityourselfbar /id_955 org.kde.plasma.doityourselfbar.pass "$DATA"
        DATA_last="$DATA"
    fi
    if [ $(cat /tmp/1 | wc -l) -gt 10 ]; then
        > /tmp/1
    fi
    /usr/bin/sleep 1
done
