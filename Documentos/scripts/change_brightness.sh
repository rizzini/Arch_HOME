#!/bin/bash
current=$(ddcutil getvcp color | awk '/\<'"0x10"'\>/{print $9}' | tr -d ',');
if [ "$1" == 'aumentar' ]; then
    i=$((current + 10));
    ddcutil setvcp 0x10 "$i";
    ddcutil setvcp 0x12 "$i";
elif [ "$1" == 'diminuir' ]; then
    i=$((current - 10));
    ddcutil setvcp 0x10 "$i";
    ddcutil setvcp 0x12 "$i";
fi
