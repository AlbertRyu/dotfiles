# eza related config
function ls
    eza --all --icons --group-directories-first $argv
end

# 树状显示目录结构,默认显示 2 层
function lt
    eza --all --tree --level=2 --icons $argv
end

# Personal Funcitons
function serve
    python3 -m http.server
end

#Activate Python Env
function activate_data
    source ~/.venvs/data/bin/activate.fish
end

#build pdf
function build_pdf
    pandoc $argv -F pandoc-crossref --citeproc -o output.pdf --pdf-engine xelatex
end

## Add zoxide as a better cd
zoxide init fish | source

# Known bug, https://github.com/IlanCosman/tide/pull/659
# This fix the chevron pointing left
set -g fish_key_bindings fish_default_key_bindings

function play_music
    set -l presets \
        "Work Music | https://www.youtube.com/watch?v=-uOUir_YSTw" \
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
