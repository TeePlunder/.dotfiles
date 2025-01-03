# How to get applications

## To install everything

```fish
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.dotfiles/.config/nix#work
```

## update flake

```fish
nix flake update
```
