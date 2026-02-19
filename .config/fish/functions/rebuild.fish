function rebuild --description "Rebuild nix-darwin system config"
    sudo nix run nix-darwin -- switch --flake ~/.dotfiles/.config#work $argv
end
