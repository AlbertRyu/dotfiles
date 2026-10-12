# Direnv install
direnv hook fish | source

# 将homebrew的path置之于最前
if status is-interactive
    eval (/opt/homebrew/bin/brew shellenv)
end
# eza related config
function ls
    eza --icons --group-directories-first $argv
end

# 树状显示目录结构,默认显示 2 层
function lt
    eza --all --tree --level=2 --icons $argv
end

## Add zoxide as a better cd
zoxide init fish | source

# Known bug, https://github.com/IlanCosman/tide/pull/659
# This fix the chevron pointing left
set -g fish_key_bindings fish_default_key_bindings

# set the greeting message to empty.
set -g fish_greeting ""
