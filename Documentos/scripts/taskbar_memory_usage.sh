#!/bin/bash
renice -n 19 -p $(pgrep  'taskbar_mem') &> /dev/null
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
        local -i fraction="$((remainder * 10 / scale))"
        if [ "$fraction" -gt 0 ]
        then
            decimal=".$fraction"
        fi
    fi
    echo "${whole}${decimal}${units[$unit]}"
}
# while :;do
    mapfile -t mem_stats < <(grep -e "MemTotal" -e "MemAvailable" -e 'SwapTotal' -e 'SwapFree' /proc/meminfo | awk '{print $2}')
    mem_used=$((mem_stats[0] - mem_stats[1] - 256000))
    swap_used_disk=$(awk '/\<'"sda5"'\>/{print $4}' /proc/swaps)
    swap_used_zram=()
    while IFS= read -r i; do
        swap_used_zram+=("$i");
    done < <(awk '/\<zram.\>/{print $4}' /proc/swaps)
    swap_used_zram_total=$((swap_used_zram[0] + swap_used_zram[1] + swap_used_zram[2] + swap_used_zram[3]))
    if [ $mem_used -ge 13000000 ];then
        DATA='| B | RAM: <b>'$(size $mem_used)'</b> \| File swap: <b>'$(size "$swap_used_disk")'</b> \| ZRAM: <b>'$(size "$swap_used_zram_total")'</b> | | |'
    else
        DATA='| A | RAM: <b>'$(size $mem_used)'</b> \| File swap: <b>'$(size "$swap_used_disk")'</b> \| ZRAM: <b>'$(size "$swap_used_zram_total")'</b> | | |'
    fi
    if [ "$DATA" != "$DATA_last" ];then
#         qdbus org.kde.plasma.doityourselfbar /id_953 org.kde.plasma.doityourselfbar.pass "$DATA"
        echo "Mem: "$(size $mem_used)""
        DATA_last="$DATA"
    fi
#         sleep 3
# done


