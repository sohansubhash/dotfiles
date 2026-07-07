function fish_prompt
    if test -n "$SSH_TTY"
        echo -n (set_color brred)"$USER"(set_color white)'@'(set_color yellow)(prompt_hostname)' '
    end
    set_color -o

    echo -n (basename (prompt_pwd))' '

    if fish_is_root_user
        echo -n (set_color --bold red)'# '
    end
    echo -n '▞ '
    set_color normal
end

