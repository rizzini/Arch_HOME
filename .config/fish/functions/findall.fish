function findall
    sudo find / -not \( -wholename "/mnt" -prune -o -wholename "/usr/share/locale" -prune -o -wholename "/home/lucas/.local/share/icons" -prune -o -wholename "/usr/share/man" -prune -o -wholename "/var/db/repos"  -prune -o -wholename "/usr/share/icons"-prune \)  -iname """*$argv[1]*""" 2> /dev/null
end

