set fish_greeting # Disable greeting

function fish_prompt --description 'DOOM rice prompt'
    set -l last_status $status

    # failed command
    if test $last_status -ne 0
        set_color ffff73
        echo -n "[$last_status] "
    end

    # path
    set_color bcbcbc
    echo -n (string replace -r "^$HOME" '~' -- $PWD)

    # git
    set -l branch (git branch --show-current 2>/dev/null)
    if test -n "$branch"
        set_color bf0000
        echo -n " ($branch"
        if not git diff --quiet --ignore-submodules HEAD 2>/dev/null
            set_color ffff73
            echo -n '*'
            set_color bf0000
        end
        echo -n ')'
    end

    # prompt char: bold bright red
    set_color -o ff3f23
    if fish_is_root_user
        echo -n ' # '
    else
        echo -n ' > '
    end
    set_color normal
end

# TV integration
tv init fish | source
