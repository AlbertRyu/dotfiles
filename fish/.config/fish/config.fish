# eza related config
function ls
    eza --all --icons --group-directories-first $argv
end

# 树状显示目录结构,默认显示 2 层
function lt
    eza --all --tree --level=2 --icons $argv
end

#Activate Python Env
function activate_data
    source ~/.venvs/Data_Analysis/bin/activate.fish
end

#build pdf
function build_pdf
    set -l output (string replace -r '\.[^.]*$' '' $argv).pdf
    pandoc $argv -F pandoc-crossref --citeproc -o $output --pdf-engine xelatex
end

## Add zoxide as a better cd
zoxide init fish | source

# Known bug, https://github.com/IlanCosman/tide/pull/659
# This fix the chevron pointing left
set -g fish_key_bindings fish_default_key_bindings
