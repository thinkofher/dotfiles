function fish_mode_prompt
    if [ $status = "0" ]
        set_color white
    else
        set_color red
    end
    echo -n (prompt_hostname)
    if [ $fish_key_bindings = fish_vi_key_bindings ]
        switch $fish_bind_mode
            case default
                set_color -d red
                echo -n '%'
            case insert
                set_color green
                echo -n ';'
            case visual
                set_color yellow
                echo -n '%'
            case replace
                set_color blue
                echo -n '%'
            case replace_one
                set_color magenta
                echo -n '%'
        end
    end
end
