function fish_right_prompt
    set -l st $status

    if [ $st != 0 ];
        echo (set_color red) ↵ $st(set_color normal)
    end

    echo -n -s $normal ' [' (date +%H:%M:%S) ']'
end
