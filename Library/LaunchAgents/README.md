# LaunchAgents

macOS launchd agents for user-level services.

## com.local.sketchybar-wake.plist

Restarts sketchybar on system wake. Prevents stale process state after long sleep/hibernation.

### Install

```bash
# From dotfiles root
stow .

# Load the agent
launchctl load ~/Library/LaunchAgents/com.local.sketchybar-wake.plist
```

### Uninstall

```bash
launchctl unload ~/Library/LaunchAgents/com.local.sketchybar-wake.plist
rm ~/Library/LaunchAgents/com.local.sketchybar-wake.plist
```

### Verify

```bash
launchctl list | grep sketchybar-wake
```
