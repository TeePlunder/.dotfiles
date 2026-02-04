# Centralized theme switcher - updates all tool configs at once
#
# Usage:
#   theme catppuccin-macchiato   # teal-ish catppuccin
#   theme catppuccin-mocha       # darker catppuccin
#   theme gruvbox-dark           # gruvbox
#   theme --list                 # show available themes
#
# Updates these configs:
#   ghostty     ~/.config/ghostty/config        theme = ...
#   wezterm     ~/.wezterm.lua                  config.color_scheme = "..."
#   bat         ~/.config/bat/config            --theme="..."
#   zellij      ~/.config/zellij/config.kdl     theme "..."
#   nvim        ~/.config/nvim/lua/plugins/catppuccin.lua   flavour = "..."
#   alacritty   ~/.config/alacritty/alacritty.toml          [colors.*] sections
#
# Adding a new theme:
#   1. Add theme name to `themes` list
#   2. Add case block with: ghostty_theme, wezterm_theme, bat_theme,
#      zellij_theme, nvim_flavour, alacritty_colors
#
# Adding a new app:
#   1. Add config path variable
#   2. Add sed/awk command to update the config file
#   3. Theme names vary per app - check app docs for exact values

function theme --description "Switch theme across all tools"
    set -l config_base "$HOME/.config"
    set -l home "$HOME"

    # Theme mappings
    set -l themes catppuccin-macchiato catppuccin-mocha gruvbox-dark

    # Handle --list
    if test "$argv[1]" = "--list"
        echo "Available themes:"
        for t in $themes
            echo "  $t"
        end
        return 0
    end

    # Validate theme
    set -l theme_name $argv[1]
    if not contains $theme_name $themes
        echo "Unknown theme: $theme_name"
        echo "Use 'theme --list' to see available themes"
        return 1
    end

    # Theme-specific values
    switch $theme_name
        case catppuccin-macchiato
            set ghostty_theme "Catppuccin Macchiato"
            set wezterm_theme "Catppuccin Macchiato"
            set bat_theme "Catppuccin Macchiato"
            set zellij_theme "catppuccin-macchiato"
            set nvim_flavour "macchiato"
            set alacritty_colors '[colors]
draw_bold_text_with_bright_colors = true

[colors.bright]
black = "0x5b6078"
blue = "0x8aadf4"
cyan = "0x8bd5ca"
green = "0xa6da95"
magenta = "0xc6a0f6"
red = "0xed8796"
white = "0xcad3f5"
yellow = "0xeed49f"

[colors.normal]
black = "0x494d64"
blue = "0x8aadf4"
cyan = "0x8bd5ca"
green = "0xa6da95"
magenta = "0xc6a0f6"
red = "0xed8796"
white = "0xb8c0e0"
yellow = "0xeed49f"

[colors.primary]
background = "0x24273a"
foreground = "0xcad3f5"'

        case catppuccin-mocha
            set ghostty_theme "Catppuccin Mocha"
            set wezterm_theme "Catppuccin Mocha"
            set bat_theme "Catppuccin Mocha"
            set zellij_theme "catppuccin-mocha"
            set nvim_flavour "mocha"
            set alacritty_colors '[colors]
draw_bold_text_with_bright_colors = true

[colors.bright]
black = "0x585b70"
blue = "0x89b4fa"
cyan = "0x94e2d5"
green = "0xa6e3a1"
magenta = "0xcba6f7"
red = "0xf38ba8"
white = "0xcdd6f4"
yellow = "0xf9e2af"

[colors.normal]
black = "0x45475a"
blue = "0x89b4fa"
cyan = "0x94e2d5"
green = "0xa6e3a1"
magenta = "0xcba6f7"
red = "0xf38ba8"
white = "0xbac2de"
yellow = "0xf9e2af"

[colors.primary]
background = "0x1e1e2e"
foreground = "0xcdd6f4"'

        case gruvbox-dark
            set ghostty_theme "GruvboxDark"
            set wezterm_theme "GruvboxDark"
            set bat_theme "gruvbox-dark"
            set zellij_theme "gruvbox-dark"
            set nvim_flavour "gruvbox"
            set alacritty_colors '[colors]
draw_bold_text_with_bright_colors = true

[colors.bright]
black = "0x928374"
blue = "0x83a598"
cyan = "0x8ec07c"
green = "0xb8bb26"
magenta = "0xd3869b"
red = "0xfb4934"
white = "0xebdbb2"
yellow = "0xfabd2f"

[colors.normal]
black = "0x282828"
blue = "0x458588"
cyan = "0x689d6a"
green = "0x98971a"
magenta = "0xb16286"
red = "0xcc241d"
white = "0xa89984"
yellow = "0xd79921"

[colors.primary]
background = "0x282828"
foreground = "0xebdbb2"'
    end

    # Update Ghostty
    set -l ghostty_config "$config_base/ghostty/config"
    if test -f $ghostty_config
        sed -i '' "s/^theme = .*/theme = $ghostty_theme/" $ghostty_config
        echo "Updated ghostty"
    end

    # Update Wezterm (resolve symlink for sed)
    set -l wezterm_config "$home/.wezterm.lua"
    if test -L $wezterm_config
        set wezterm_config (readlink -f $wezterm_config)
    end
    if test -f $wezterm_config
        sed -i '' "s/config.color_scheme = \".*\"/config.color_scheme = \"$wezterm_theme\"/" $wezterm_config
        echo "Updated wezterm"
    end

    # Update Bat
    set -l bat_config "$config_base/bat/config"
    if test -f $bat_config
        sed -i '' "s/--theme=\".*\"/--theme=\"$bat_theme\"/" $bat_config
        echo "Updated bat"
    end

    # Update Zellij
    set -l zellij_config "$config_base/zellij/config.kdl"
    if test -f $zellij_config
        sed -i '' "s/^theme \".*\"/theme \"$zellij_theme\"/" $zellij_config
        echo "Updated zellij"
    end

    # Update Neovim catppuccin
    set -l nvim_catppuccin "$config_base/nvim/lua/plugins/catppuccin.lua"
    if test -f $nvim_catppuccin
        sed -i '' "s/flavour = \".*\"/flavour = \"$nvim_flavour\"/" $nvim_catppuccin
        echo "Updated nvim"
    end

    # Update Alacritty (replace entire colors section)
    set -l alacritty_config "$config_base/alacritty/alacritty.toml"
    if test -f $alacritty_config
        # Read non-color sections and append new colors
        set -l tmp_file (mktemp)
        awk '/^\[colors/ {skip=1} /^\[/ && !/^\[colors/ {skip=0} !skip' $alacritty_config > $tmp_file
        echo "" >> $tmp_file
        echo "$alacritty_colors" >> $tmp_file
        mv $tmp_file $alacritty_config
        echo "Updated alacritty"
    end

    echo "Theme switched to: $theme_name"
    echo "Restart terminal/apps to apply"
end
