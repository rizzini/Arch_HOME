#!/bin/bash
current=$(ddcutil getvcp color | awk '/\<'"0x10"'\>/{print $9}' | tr -d ',');
case $1 in
'aumentar')
        i=$((current + 10))
        if [ "$i" -le 100  ]; then
            ddcutil setvcp 0x10 "$i";
            ddcutil setvcp 0x12 "$i";
        else
            ddcutil setvcp 0x10 "100";
            ddcutil setvcp 0x12 "100";
        fi
        ;;
'diminuir')
        i=$((current - 10))
        if [ "$i" -ge 0  ]; then
            ddcutil setvcp 0x10 "$i";
            ddcutil setvcp 0x12 "$i";
        else
            ddcutil setvcp 0x10 "0";
            ddcutil setvcp 0x12 "0";
        fi
        ;;
''|*[0-9]*)
        if [ "$1" -le 100 ] && [ "$1" -ge 0 ]; then
            ddcutil setvcp 0x10 "$1";
            ddcutil setvcp 0x12 "$1";
        fi
        ;;
esac
