-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.font = wezterm.font("JetBrains Mono")
config.font_size = 14.0
config.color_scheme = "Gruvbox Dark (Gogh)"
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 1.0

-- and finally, return the configuration to wezterm
return config
