function switch_theme --description "Switch theme across all apps (dark/light)"
    set -l mode $argv[1]

    if test -z "$mode"
        echo "Usage: switch_theme <dark|light>"
        return 1
    end

    if test "$mode" != "dark" -a "$mode" != "light"
        echo "Invalid mode: $mode. Use 'dark' or 'light'"
        return 1
    end

    set -l config_dir ~/.config

    # Alacritty: swap theme import
    set -l alacritty_config "$config_dir/alacritty/alacritty.toml"
    if test -f "$alacritty_config"
        if test "$mode" = "dark"
            sed -i '' 's|themes/catppuccin-latte.toml|themes/catppuccin-mocha.toml|' "$alacritty_config"
        else
            sed -i '' 's|themes/catppuccin-mocha.toml|themes/catppuccin-latte.toml|' "$alacritty_config"
        end
        touch "$alacritty_config" # trigger live reload
    end

    # Zellij: swap theme
    set -l zellij_config "$config_dir/zellij/config.kdl"
    if test -f "$zellij_config"
        if test "$mode" = "dark"
            sed -i '' 's/theme "catppuccin-latte"/theme "catppuccin-mocha"/' "$zellij_config"
        else
            sed -i '' 's/theme "catppuccin-mocha"/theme "catppuccin-latte"/' "$zellij_config"
        end
    end

    # Bat: set universal env var
    if test "$mode" = "dark"
        set -Ux BAT_THEME "Catppuccin Mocha"
    else
        set -Ux BAT_THEME "Catppuccin Latte"
    end

    # Sketchybar: copy colors file and reload
    set -l sketchybar_dir "$config_dir/sketchybar"
    if test -d "$sketchybar_dir"
        if test "$mode" = "dark"
            cp "$sketchybar_dir/colors-mocha.sh" "$sketchybar_dir/colors.sh"
        else
            cp "$sketchybar_dir/colors-latte.sh" "$sketchybar_dir/colors.sh"
        end
        sketchybar --reload 2>/dev/null
    end

    # Neovim: handled by auto-dark-mode.nvim plugin (watches system appearance)

    echo "Theme switched to $mode"
end
