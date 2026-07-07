function fish_mode_prompt
    switch $fish_bind_mode
        case insert
            set_color -o blue
        case default
        case visual
            set_color -o cyan
    end
    set_color -o
    echo -n '▞ '
    set_color normal
end

