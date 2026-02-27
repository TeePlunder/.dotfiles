# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Apply dotfiles symlinks
stow .

# Override existing files with dotfiles
stow --adopt .

# Install/update all packages via nix-darwin
sudo nix run nix-darwin -- switch --flake .#work

# Update nix flake dependencies
nix flake update
```

## Architecture

**Package management:** Nix flakes (`.config/nix/flake.nix`) manages homebrew brews/casks and system config via nix-darwin. GNU Stow creates symlinks from this repo to `~`.

**Primary configs:**
- `fish/` - main shell (functions in `functions/`, FZF via fisher plugin)
- `nvim/` - main editor (lazy.nvim, plugins in `lua/plugins/`)
- `zellij/` - terminal multiplexer (vim keybindings, locked mode default)
- `sketchybar/` - macOS menu bar (plugins/, items/, helper C binary)
- `nix/flake.nix` - package declarations, macOS system settings

**Secondary:** zed (GUI editor), alacritty/ghostty (terminals), starship (prompt), amethyst (window tiling)

**Theme:** catppuccin-macchiato. **Font:** JetBrains Mono NF 14pt.

## Config Patterns

- Fish functions: one file per function in `fish/functions/`
- Neovim plugins: one file per plugin in `nvim/lua/plugins/`, lazy-loaded
- Sketchybar: items define UI elements, plugins provide data scripts
