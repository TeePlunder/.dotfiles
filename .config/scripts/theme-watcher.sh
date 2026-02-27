#!/bin/bash
# Wrapper for dark-notify to call switch_theme.fish
# Usage: dark-notify -c theme-watcher.sh
# $1 will be "dark" or "light"
/opt/homebrew/bin/fish -c "switch_theme $1"
