#!/bin/bash
renice -n 19 -p $(pgrep  'taskbar_disk') &> /dev/null
export LANG=C LC_ALL=C;
declare -A data1_read data1_write read write threshold show counter counter_no_data;
while :; do
    readarray -t disk_list < <(awk '(!/[0-9]$/)&&(NR>2){print $4}' /proc/partitions);
    DATA=();
    has_data=();
    for disk in "${disk_list[@]}"; do
        counter[$disk]=$((counter[$disk]+1));
        data1_read[$disk]=$(awk '/\<'"$disk"'\>/{print $6}' /proc/diskstats);
        data1_write[$disk]=$(awk '/\<'"$disk"'\>/{print $10}' /proc/diskstats);
    done
    sleep 0.5;
    for disk in "${disk_list[@]}"; do
        data2_read[$disk]=$(awk '/\<'"$disk"'\>/{print $6}' /proc/diskstats);
        data2_write[$disk]=$(awk '/\<'"$disk"'\>/{print $10}' /proc/diskstats);
        read[$disk]=$((data2_read[$disk] - data1_read[$disk]));
        write[$disk]=$((data2_write[$disk] - data1_write[$disk]));
        read[$disk]=$((${read[$disk]%%}/1024));
        write[$disk]=$((${write[$disk]%%}/1024));
        if [[ "$(lsblk -do name,tran | grep "$disk")" == *"usb"* ]]; then
            threshold[$disk]=1;
        else
            threshold[$disk]=10;
        fi
        if [[ ${read[$disk]} -ge ${threshold[$disk]} || ${write[$disk]} -ge ${threshold[$disk]} || ${show[$disk]} -eq 1 ]]; then
            DATA+='| A | '${disk}'\| R: <b>'${read[$disk]}'MB/s</b> W: <b>'${write[$disk]}'MB/s</b> | | |';
            has_data+=("$disk");
        fi
        if [[ "${has_data[*]}" == *"$disk"* ]]; then
            show[$disk]=1;
        else
            counter_no_data[$disk]=$((counter_no_data[$disk]+1));
        fi
        if [ $((counter_no_data[$disk]+5)) == ${counter[$disk]} ]; then
            show[$disk]=0;
            counter[$disk]=0;
            counter_no_data[$disk]=0;
        fi
    done
    if [ ! "$has_data" ];then
        DATA='| A | Sem atividade de disco | | |';
    fi
    if [ "$DATA" != "$DATA_last" ];then
        if [ "$1" == 'terminal' ]; then
        clear
            printf "\r'${disk}' ---> R: ${read[$disk]}MB/s _ W: ${write[$disk]}MB/s";
        else
            /usr/lib/qt6/bin/qdbus org.kde.plasma.doityourselfbar /id_951 org.kde.plasma.doityourselfbar.pass "${DATA[@]}";
        fi
        DATA_last="$DATA";
    fi
    sleep 1;
done
