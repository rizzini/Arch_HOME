function cat
    if not /usr/bin/highlight -O ansi --force ""$argv[1]"" 2> /dev/null;
        /bin/cat ""$argv[1]"";
    end
end
