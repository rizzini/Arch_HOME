set fish_greeting;
starship init fish | source
set VIRTUAL_ENV_DISABLE_PROMPT "1";
source ~/.profile;
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end
alias plasmashell='/usr/bin/killall plasmashell &> /dev/null; /usr/bin/plasmashell --replace &> /dev/null & disown $last_pid';
alias ls='/usr/bin/exa -al --color=always --group-directories-first';
alias l='/usr/bin/exa -al --color=always --group-directories-first';
alias grep='/bin/grep --color=auto';
# alias gitpkg='/usr/bin/pacman -Q | grep -i "\-git" ';
alias syadm="/usr/bin/sudo /usr/bin/yadm -Y /etc/yadm";
#alias cat='/usr/bin/bat -p ';
# alias cat="highlight -O ansi --force"
alias bv='/home/lucas/Documentos/scripts/download_videos_terminal.sh'
alias packagelist='expac --timefmt="%Y-%m-%d %T" "%l\t%n" | sort'
alias radeontop='radeontop -Tc'
