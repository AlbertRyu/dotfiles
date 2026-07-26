function play_music
    set -l presets \
        "Work Music | https://www.youtube.com/watch?v=-uOUir_YSTw" \
        "Hyrule Zelda | https://www.youtube.com/watch?v=HGq5AfuYAIo" \
        "Ace Attorney | https://www.youtube.com/watch?v=XXrKbxpVfKc" \
        "Lofi Girl | https://www.youtube.com/watch?v=X4VbdwhkE10"

    for i in (seq (count $presets))
        echo "$i), $presets[$i]"
    end

    read -l -n 1 -P "Which link you want: " answer

    set -l name (string split ' | ' $presets[$answer])[1]
    set -l link (string split ' | ' $presets[$answer])[2]

    echo "you have chosed $name"
    mpv --no-video $link

end
