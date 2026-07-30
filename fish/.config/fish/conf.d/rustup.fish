# fish/.config/fish/conf.d/rustup.fish
if test -d "$HOME/.cargo/bin"
    fish_add_path -g "$HOME/.cargo/bin"
end
