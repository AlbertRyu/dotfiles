# eza related config
function ls
    eza --icons --group-directories-first $argv
end

# 树状显示目录结构,默认显示 2 层
function lt
    eza --tree --level=2 --icons $argv
end

# Personal Funcitons
function play_lofi
    mpv --no-video 'https://www.youtube.com/watch?v=X4VbdwhkE10'
end

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
