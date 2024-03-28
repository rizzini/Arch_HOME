#!/bin/bash
atualizado=0
rm -f /tmp/LoudnessEqualizer.json
wget https://raw.githubusercontent.com/Digitalone1/EasyEffects-Presets/master/LoudnessEqualizer.json -P /tmp/;
if ! colordiff /tmp/LoudnessEqualizer.json /home/lucas/.config/easyeffects/output/LoudnessEqualizer.json &> /dev/null; then
    mv -f /tmp/LoudnessEqualizer.json /home/lucas/.config/easyeffects/output/LoudnessEqualizer.json;
    atualizado=1
else
    /usr/bin/notify-send -u critical 'LoudnessEqualizer já está na versão mais recente.';
    exit
fi
if [ $atualizado -eq 1 ]; then
    /usr/bin/notify-send -u critical 'LoudnessEqualizer atualizado para a versão mais recente';
else
    /usr/bin/notify-send -u critical 'LoudnessEqualizer não atualizado';
fi

rm -f /tmp/LoudnessEqualizer.json
