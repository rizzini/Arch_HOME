function d
    if [ -z "$argv[1]" ]
        /usr/bin/xdg-open . &> /dev/null & disown $last_pid
    else if [ -n "$argv[1]" ]
        /usr/bin/xdg-open "$argv[1]" &> /dev/null & disown $last_pid
    end
end
