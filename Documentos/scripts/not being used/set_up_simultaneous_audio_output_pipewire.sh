#!/bin/bash
db='/home/lucas/Documentos/scripts/set_up_simultaneous_audio_output_pipewire.sh.db'
minisystem_sink_name='alsa_output.pci-0000_00_1f.3.pro-output-0'
hdmi_sink_name='alsa_output.pci-0000_00_1f.3.pro-output-3'
source_name='alsa_input.pci-0000_00_1f.3.pro-input-0'
if pactl list sinks | grep -q combination; then
    minisystem_right="$(pactl get-sink-volume "$minisystem_sink_name" | awk '{print $12}')"
    minisystem_left="$(pactl get-sink-volume "$minisystem_sink_name" | awk '{print $5}')"
    hdmi_right="$(pactl get-sink-volume "$hdmi_sink_name" | awk '{print $12}')"
    hdmi_left="$(pactl get-sink-volume "$hdmi_sink_name" | awk '{print $5}')"
    combination_right="$(pactl get-sink-volume 'combination-sink' | awk '{print $12}')";
    combination_left="$(pactl get-sink-volume 'combination-sink' | awk '{print $5}')";
    echo 'minisystem '"$minisystem_right"' '"$minisystem_left"'' | tee "$db"
    echo 'hdmi '"$hdmi_right"' '"$hdmi_left"'' | tee -a "$db"
    echo 'combination '"$combination_right"' '"$combination_left"'' | tee -a "$db"
    pactl unload-module module-combine-sink;
    pactl set-sink-volume "$minisystem_sink_name" "$(awk '/\<'"minisystem"'\>/{print $2}' "$db")" "$(awk '/\<'"minisystem"'\>/{print $3}' "$db")";
    pactl set-sink-volume "$hdmi_sink_name" "$(awk '/\<'"hdmi"'\>/{print $3}' "$db")";
    pactl set-default-source "$source_name"
    if [ "$(awk '/\<'"default"'\>/{print $1}' "$db")" == 'minisystem' ]; then
        pactl set-default-sink "$minisystem_sink_name"
    elif [ "$(awk '/\<'"default"'\>/{print $1}' "$db")" == 'hdmi' ]; then
        pactl set-default-sink "$hdmi_sink_name"
    fi
else
    pkill easyeffects
    minisystem_right="$(pactl get-sink-volume "$minisystem_sink_name" | awk '{print $12}')"
    minisystem_left="$(pactl get-sink-volume "$minisystem_sink_name" | awk '{print $5}')"
    hdmi_right="$(pactl get-sink-volume "$hdmi_sink_name" | awk '{print $12}')"
    hdmi_left="$(pactl get-sink-volume "$hdmi_sink_name" | awk '{print $5}')"
    echo 'minisystem '"$minisystem_right"' '"$minisystem_left"'' | tee "$db"
    echo 'hdmi '"$hdmi_right"' '"$hdmi_left"'' | tee -a "$db"
    if [ "$(pactl get-default-sink)" == "$minisystem_sink_name" ]; then
        sed -i 's/.*minisystem.*/& default/' "$db"
    elif [ "$(pactl get-default-sink)" == "$hdmi_sink_name" ]; then
        sed -i 's/.*hdmi.*/& default/' "$db"
    fi
    pactl load-module module-combine-sink sink_name=combination-sink sink_properties=slaves="$hdmi_sink_name","$minisystem_sink_name" channels=2;
    pactl set-sink-volume "$minisystem_sink_name" "$(awk '/\<'"minisystem"'\>/{print $2}' "$db")" "$(awk '/\<'"minisystem"'\>/{print $3}' "$db")"
    pactl set-sink-volume "$hdmi_sink_name" "$(awk '/\<'"minisystem"'\>/{print $3}' "$db")" "$(awk '/\<'"minisystem"'\>/{print $3}' "$db")"
    pactl set-sink-volume 'combination-sink' "$(awk '/\<'"combination"'\>/{print $2}' "$db")" "$(awk '/\<'"combination"'\>/{print $3}' "$db")"
    pactl set-default-source "$source_name"
    pactl set-default-sink combination-sink;
fi
