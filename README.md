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

### Create tokens

Both are Atlassian API tokens, created at [id.atlassian.com → Security → API tokens](https://id.atlassian.com/manage-profile/security/api-tokens). Shown once, max 1 year expiry.

- **Bitbucket:** "Create API token **with scopes**" → app Bitbucket. Scopes: `read:account`, `read:user:bitbucket`, `read:workspace:bitbucket`, `read:repository:bitbucket`, `read:pullrequest:bitbucket`, `write:pullrequest:bitbucket`, `read:pipeline:bitbucket`.
- **Jira:** "Create API token" (unscoped works for Jira).

Token must start with `ATATT`. `ATCTT` = workspace/repo access token: Bearer-only, no user, atlas gets 401.

### Store in Keychain

Paste token into hidden prompt (no clipboard/history mixups):

```fish
read -s -P "token: " t; and security add-generic-password -U -a $USER -s bitbucket-token -w $t; set -e t
read -s -P "token: " t; and security add-generic-password -U -a $USER -s jira-token -w $t; set -e t
```

Don't use `security`'s own interactive `-w` prompt: truncates input to 128 chars, Atlassian tokens are ~190.

### Create the file

Username for both = Atlassian account email.

```fish
set -gx BITBUCKET_USER "you@example.com"
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

Neovim reads them via `vim.env.*` (e.g. `nvim/lua/plugins/atlas.lua`). Env is read at shell start: after changing a token, `exec $SHELL` and restart nvim — running shells/nvims keep the old value.

### Verify

```fish
curl -s -o /dev/null -w "%{http_code}\n" -u "$BITBUCKET_USER:$BITBUCKET_TOKEN" https://api.bitbucket.org/2.0/user
curl -s -o /dev/null -w "%{http_code}\n" -u "$JIRA_EMAIL:$JIRA_TOKEN" "$JIRA_BASE_URL/rest/api/3/myself"
```

Both should print `200`. In nvim: `:lua print(vim.env.BITBUCKET_TOKEN:sub(1, 5))` → `ATATT`.

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
