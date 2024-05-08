local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.window_decorations = "RESIZE" -- 禁用标题栏

config.window_close_confirmation = "NeverPrompt" -- 禁用窗口关闭提示

config.window_background_opacity = 0.94
config.tab_bar_at_bottom = true
config.enable_tab_bar = true

config.color_scheme = "Gruvbox Material (Gogh)"

-- Ⅳa
config.freetype_load_flags = "NO_HINTING|NO_AUTOHINT"
config.font = wezterm.font_with_fallback({
	{ family = "JetBrainsMono Nerd Font" },
	{ family = "Maple Mono SC NF" },
	{ family = "Iosevka Term" },
})
config.font_size = 14
config.line_height = 1.4

require("keymaps").setup(config)
require("tabs")

return config
