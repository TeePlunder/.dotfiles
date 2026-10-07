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

## Secrets

Secrets (API tokens etc.) live in `~/.secrets.fish`, outside the repo. Never commit them or use `set -Ux` (writes to tracked `fish_variables`).

Store tokens in the macOS Keychain (prompts for the value):

```fish
security add-generic-password -a $USER -s bitbucket-token -w
security add-generic-password -a $USER -s jira-token -w
```

Update an existing entry by adding `-U`.

Create the file:

```fish
set -gx BITBUCKET_USER "you"
set -gx BITBUCKET_TOKEN (security find-generic-password -a $USER -s bitbucket-token -w 2>/dev/null)
set -gx JIRA_BASE_URL "https://your-site.atlassian.net"
set -gx JIRA_EMAIL "you@example.com"
set -gx JIRA_TOKEN (security find-generic-password -a $USER -s jira-token -w 2>/dev/null)
```

Restrict permissions:

```fish
chmod 600 ~/.secrets.fish
```

`config.fish` sources it if present:

```fish
test -f ~/.secrets.fish; and source ~/.secrets.fish
```

Neovim reads them via `vim.env.*` (e.g. `nvim/lua/plugins/atlas.lua`). Restart the shell before launching nvim. Verify with `:lua print(vim.env.JIRA_TOKEN)`.

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

## install everything

Reade more [here](./.config/nix/README.md)
