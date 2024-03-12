#!/bin/bash

echo "Sessões tmux: $(tmux ls | awk '{print $1}' | tr -d ':') | bash='/usr/bin/alacritty -e tmux attach -t $(tmux ls | awk '{print $1}' | tr -d ':')'"


