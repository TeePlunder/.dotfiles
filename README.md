# My dotfiles

This directory contains the dotfiles for my system

## Requirements

Ensure you have the following installed on your system

### Git

```
brew install git
```

### Stow

```
brew install stow
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git

```
git clone git@github.com/teeplunder/.dotfiles.git
cd .dotfiles
```

then use GNU stow to create symlinks

```
stow .
```

### Override

When files already exists you can override it with

```
stow --adopt .
```

## Tutorial

[The Video](https://youtu.be/y6XCebnB9gs?si=XKJVomggYPDYyLN2)

# Nix Package-Manager

Install it using the guide from [Nix-Docs](https://nixos.org/download/). I followed this [video](https://youtu.be/Z8BL8mdzWHI?si=BpJHaY3-7phbASsm)

on Fish you need to run this cmd

```fish
curl -L https://nixos.org/nix/install | sh
```

Restart your shell and run to confirm it is working

```fish
nix-shell -p neofetch --run neofetch
```
