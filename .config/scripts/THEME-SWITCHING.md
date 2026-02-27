# Auto Theme Switching

System appearance changes trigger automatic theme updates across apps.

## How It Works

```
macOS appearance → dark-notify daemon → switch_theme.fish → apps
```

## App Status

| App | Method | Auto? |
|-----|--------|-------|
| Ghostty | Native dual-theme syntax | Yes |
| Zed | `"mode": "system"` | Yes |
| Neovim | `flavour = "auto"` + remote bg | Yes |
| Alacritty | Import swap + touch | Yes |
| Zellij | Config edit | Yes* |
| Bat | `BAT_THEME` env | New shells |
| Sketchybar | Colors file + reload | Yes |

*Zellij: new panes pick up theme, existing sessions need restart.

## Manual Usage

```fish
switch_theme dark
switch_theme light
```

## Setup

1. Install dark-notify:
```bash
brew install cormacrelf/tap/dark-notify
# or rebuild nix: sudo nix run nix-darwin -- switch --flake .#work
```

2. Install bat themes (one-time):
```bash
mkdir -p "$(bat --config-dir)/themes"
curl -o "$(bat --config-dir)/themes/Catppuccin Mocha.tmTheme" \
  https://raw.githubusercontent.com/catppuccin/bat/main/themes/Catppuccin%20Mocha.tmTheme
curl -o "$(bat --config-dir)/themes/Catppuccin Latte.tmTheme" \
  https://raw.githubusercontent.com/catppuccin/bat/main/themes/Catppuccin%20Latte.tmTheme
bat cache --build
```

3. Copy LaunchAgent and load:
```bash
cp ~/.config/scripts/local.theme-switcher.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/local.theme-switcher.plist
```

4. Apply stow:
```bash
cd ~/.dotfiles && stow .
```

## Zellij Note

Zellij config lives directly at `~/.config/zellij/config.kdl` (not stowed) so the script can edit it for live reload. Copy manually if needed:

```bash
cp ~/.dotfiles/.config/zellij/config.kdl ~/.config/zellij/
```

## Troubleshooting

**Check daemon status:**
```bash
launchctl list | grep theme-switcher
```

**View logs:**
```bash
tail -f /tmp/theme-switcher.log
tail -f /tmp/theme-switcher.err
```

**Restart daemon:**
```bash
launchctl unload ~/Library/LaunchAgents/local.theme-switcher.plist
launchctl load ~/Library/LaunchAgents/local.theme-switcher.plist
```

**Test manually:**
```bash
dark-notify -c ~/.config/scripts/theme-watcher.sh
# or directly:
fish -c "switch_theme dark"
```

## Adding New Apps

Edit `fish/functions/switch_theme.fish` and add logic for the new app. Pattern:

1. Check if config file exists
2. Use `sed` or `cp` to update theme
3. Trigger reload if app supports it
