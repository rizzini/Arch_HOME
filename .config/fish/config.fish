set fish_greeting;
starship init fish | source
set VIRTUAL_ENV_DISABLE_PROMPT "1";
# source ~/.profile;
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end
alias plasmashell='/usr/bin/killall plasmashell &> /dev/null; /usr/bin/plasmashell --replace &> /dev/null & disown $last_pid';
alias ls='/usr/bin/exa -al --color=always --group-directories-first';
alias l='/usr/bin/exa -al --color=always --group-directories-first';
alias grep='/bin/grep --color=auto';
alias syadm="/usr/bin/sudo /usr/bin/yadm -Y /etc/yadm";
alias bv='~/scripts/download_videos_terminal.sh'
alias packagelist='expac --timefmt="%Y-%m-%d %T" "%l\t%n" | sort'
alias taskbar='/home/lucas/Documentos/scripts/taskbar_cpu_usage_temp.sh & disown; /
/home/lucas/Documentos/scripts/taskbar_disk_monitor.sh & disown; /
/home/lucas/Documentos/scripts/taskbar_memory_usage.sh & disown; /
/home/lucas/Documentos/scripts/taskbar_network_speed_monitor.sh & disown; /
/home/lucas/Documentos/scripts/taskbar_volume.sh & disown'
