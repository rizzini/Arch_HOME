#!/bin/bash
renice -n 19 -p $(pgrep  'taskbar_netw')
export LANG=C LC_ALL=C
size () {
    local -a units
    local -i scale
    scale=1000
    units=(KB MB GB)
    local -i unit=0
    if [ -z "${units[0]}" ]
    then
        unit=1
    fi
    local -i whole=${1:-0}
    local -i remainder=0
    while (( whole >= scale ))
    do
        remainder=$(( whole % scale ))
        whole=$((whole / scale))
        unit=$(( unit + 1 ))
    done
    local decimal
    if [ $remainder -gt 0 ]
    then
        local -i fraction="$(( remainder * 10 / scale))"
        if [ "$fraction" -gt 0 ]
        then
            decimal=".$fraction"
        fi
    fi
    echo "${whole}${decimal}${units[$unit]}"
}
command='if [ "$(pgrep "nethogs")" ];then sudo /usr/bin/killall nethogs &> /dev/null;else /usr/bin/alacritty -o window.dimensions.lines=30 window.dimensions.columns=120 -e /usr/bin/sudo /usr/sbin/nethogs & disown;fi'
while :;do
    dl=$(awk '/\<enp1s0\>/{print $2}' /proc/net/dev)
    up=$(awk '/\<enp1s0\>/{print $10}' /proc/net/dev)
    sleep 1
    dl_=$(awk '/\<enp1s0\>/{print $2}' /proc/net/dev)
    up_=$(awk '/\<enp1s0\>/{print $10}' /proc/net/dev)
    dl_final=$(size $(( (dl_-dl) / 1024 )))
    up_final=$(size $(( (up_-up) / 1024 )))
    DATA='| A | Dl: <b>'$dl_final'/s</b> Up: <b>'$up_final'/s</b> | Download total: <b>'$(size $((dl_/1024)))'</b> Upload total: <b>'$(size $((up_/1024)))'</b> | '$command' |'
    if [ "$DATA" != "$DATA_last" ];then
        qdbus org.kde.plasma.doityourselfbar /id_952 org.kde.plasma.doityourselfbar.pass "$DATA"
        DATA_last="$DATA"
    fi
done
