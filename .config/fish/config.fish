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
alias ls='/usr/bin/exa -al --color=always --group-directories-first --icons';
alias l='/usr/bin/exa -al --color=always --group-directories-first --icons';
alias grep='/bin/grep --color=auto';
alias syadm="/usr/bin/sudo /usr/bin/yadm -Y /etc/yadm";
alias packagelist='expac --timefmt="%Y-%m-%d %T" "%l\t%n" | sort'
bind \b backward-kill-path-component
alias intel='sudo intel_gpu_top'

