#!/bin/bash
renice -n 19 -p $(pgrep  'taskbar_mem')
/usr/bin/sleep 3
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
        local -i fraction="$(( (remainder * 10 / scale)))"
        if [ "$fraction" -gt 0 ]
        then
            decimal=".$fraction"
        fi
    fi
    echo "${whole}${decimal}${units[$unit]}"
}
# command='if [ "$(pgrep "intel_gpu_top")" ];then /usr/bin/sudo /usr/bin/killall intel_gpu_top;else /usr/bin/alacritty -o window.dimensions.lines=13 window.dimensions.columns=55 -e /usr/bin/sudo /usr/bin/intel_gpu_top;fi'
command='';
while :;do
    mem_stats=()
    mem_stats+=($(/bin/grep -e "MemTotal" -e "MemAvailable" -e 'SwapTotal' -e 'SwapFree' /proc/meminfo))
    mem_used=$(((mem_stats[1] - mem_stats[4]) - 256000))
    swap_used=$((mem_stats[7] - mem_stats[10]))
#     if /bin/grep -q 'ENABLED=no' /etc/ufw/ufw.conf; then
#         DATA='| C | Firewall <b>desativado</b> \| RAM: <b>'$(size $mem_used)'</b> \| Swap: <b>'$(size $swap_used)'</b> | | '$command' |';
    if [ "$(/usr/bin/pgrep easyeffects)" ]; then
        if [ $mem_used -ge 7000000 ];then
            DATA='| B | EasyEffects <b>ligado</b> \| RAM: <b>'$(size $mem_used)'</b> \| Swap: <b>'$(size $swap_used)'</b> | | '$command' |'
        else
            DATA='| A | EasyEffects <b>ligado</b> \| RAM: <b>'$(size $mem_used)'</b> \| Swap: <b>'$(size $swap_used)'</b> | | '$command' |'
        fi
    else
        if [ $mem_used -ge 7000000 ];then
            DATA='| B | Consumo RAM: <b>'$(size $mem_used)'</b> \| Swap: <b>'$(size $swap_used)'</b> | | '$command' |'
        else
            DATA='| A | Consumo RAM: <b>'$(size $mem_used)'</b> \| Swap: <b>'$(size $swap_used)'</b> | | '$command' |'
        fi
    fi
    if [ "$DATA" != "$DATA_last" ];then
        /usr/bin/qdbus org.kde.plasma.doityourselfbar /id_953 org.kde.plasma.doityourselfbar.pass "$DATA"
        DATA_last="$DATA"
    fi
    /usr/bin/sleep 3
done
