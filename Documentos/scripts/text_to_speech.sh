#!/bin/bash
if pgrep spd-say; then
    spd-say -S;
fi
i="$(xsel -p | sed '/^$/d')";
spd-say --wait "$i";
