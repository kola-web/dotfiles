local wezterm = require("wezterm")
local config = wezterm.config_builder()
wezterm.log_info("reloading")

-- config.term = "wezterm"

config.window_close_confirmation = "AlwaysPrompt"
config.window_decorations = "RESIZE"
config.tab_bar_at_bottom = true
config.tab_max_width = 40
config.enable_tab_bar = true
config.use_fancy_tab_bar = false

config.color_scheme = "GruvboxDark"

config.window_background_opacity = 0.94

config.font = wezterm.font_with_fallback({
	"JetBrains Mono",
	"Sarasa Term Slab SC",
})
config.font_size = 14
config.line_height = 1.4
config.freetype_load_target = "Normal"
config.freetype_render_target = "Normal"

-- config.underline_thickness = 3
-- config.cursor_thickness = 2
config.underline_position = -6

require("keymaps").setup(config)
require("tabs")
require("event")

return config
