#!/bin/bash
export LANG=C LC_ALL=C;
if [ "$1" == 'aumentar' ]; then
    new_right_volume=$(($(pactl get-sink-volume "$(pactl get-default-sink)" | awk '{print $12}' | tr -d '%') + 5));
    if [[ "$(pactl list sinks | grep Fones | awk '{print $13}' | tr -d ')')" == 'not' ]]; then
        new_left_volume=$((new_right_volume - 15));
    else
        new_left_volume="$new_right_volume"
    fi
    if [ $new_right_volume -le 150 ]; then
        pactl set-sink-volume "$(pactl get-default-sink)" "$new_left_volume"'%' "$new_right_volume"'%';
    fi
elif [ "$1" == 'diminuir' ]; then
    new_right_volume=$(($(pactl get-sink-volume "$(pactl get-default-sink)" | awk '{print $12}' | tr -d '%') - 5));
    if [[ "$(pactl list sinks | grep Fones | awk '{print $13}' | tr -d ')')" == 'not' ]]; then
        new_left_volume=$((new_right_volume - 15));
    else
        new_left_volume="$new_right_volume"
    fi
    pactl set-sink-volume "$(pactl get-default-sink)" "$new_left_volume"'%' "$new_right_volume"'%';
fi
