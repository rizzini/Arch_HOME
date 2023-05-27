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
    while (( whole >= $scale ))
    do
        remainder=$(( whole % scale ))
        whole=$((whole / scale))
        unit=$(( $unit + 1 ))
    done
    local decimal
    if [ $remainder -gt 0 ]
    then
        local -i fraction="$(( (remainder * 10 / scale)))"
        if [ "$fraction" -gt 0 ]
        then
            decimal=".$fraction"
        fi
    fi
    echo "${whole}${decimal}${units[$unit]}"
}
comando='/usr/bin/alacritty -o window.dimensions.lines=30 window.dimensions.columns=120 -e /usr/bin/sudo /usr/sbin/nethogs'
while :;do
    dl=$(/usr/bin/awk '/\<enp2s0\>/{print $2}' /proc/net/dev)
    up=$(/usr/bin/awk '/\<enp2s0\>/{print $10}' /proc/net/dev)
    /usr/bin/sleep 1
    dl_=$(/usr/bin/awk '/\<enp2s0\>/{print $2}' /proc/net/dev)
    up_=$(/usr/bin/awk '/\<enp2s0\>/{print $10}' /proc/net/dev)
    dl_final=$(size $(( (dl_-dl) / 1024 )))
    up_final=$(size $(( (up_-up) / 1024 )))
    DATA='| A | Dl: <b>'$dl_final'/s</b> Up: <b>'$up_final'/s</b> | Download total: <b>'$(size $((dl_/1024)))'</b> Upload total: <b>'$(size $((up_/1024)))'</b> | '$comando' |'
    if [ "$DATA" != "$DATA_last" ];then
        /usr/bin/qdbus org.kde.plasma.doityourselfbar /id_952 org.kde.plasma.doityourselfbar.pass "$DATA"
        DATA_last="$DATA"
    fi
done
