local wezterm = require("wezterm")
local config = wezterm.config_builder()
wezterm.log_info("reloading")

-- config.term = "wezterm"

config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.tab_bar_at_bottom = true
config.tab_max_width = 40
config.enable_tab_bar = true
config.use_fancy_tab_bar = false

config.color_scheme = "GruvboxDark"

config.allow_square_glyphs_to_overflow_width = "Always"
config.bold_brightens_ansi_colors = true
config.window_background_opacity = 0.94

config.font = wezterm.font("JetBrainsMono Nerd Font")
-- config.font = wezterm.font("Maple Mono")
config.font_size = 14
config.line_height = 1.4

-- config.underline_thickness = 3
-- config.cursor_thickness = 2
config.underline_position = -6

config.use_dead_keys = false

require("keymaps").setup(config)
require("tabs")
require("event")

return config
