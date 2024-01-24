local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- require("tabs").setup(config)

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.tab_bar_at_bottom = true
-- config.enable_tab_bar = false
config.use_fancy_tab_bar = false

config.color_scheme = "GruvboxDark"
-- config.color_scheme = "GruvboxDark"
-- config.window_background_image = "/Users/lijialin/Pictures/wallpapers/ghibili/(1988) My Neighbour Totoro/A Bridge.png"

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.allow_square_glyphs_to_overflow_width = "Always"
config.bold_brightens_ansi_colors = true
config.window_background_opacity = 0.94
config.freetype_load_flags = "NO_HINTING"

config.enable_scroll_bar = true

config.font_size = 14
config.front_end = "WebGpu"
config.line_height = 1.4

require("keymaps").setup(config)
require("tabs")
require("event")

return config
