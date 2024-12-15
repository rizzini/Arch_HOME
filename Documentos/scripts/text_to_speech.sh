#!/bin/bash
export LLC_ALL=C
if pgrep spd-say; then
    spd-say -C;
fi
i="$(xsel -p | sed '/^$/d')";
spd-say --wait "$i";
