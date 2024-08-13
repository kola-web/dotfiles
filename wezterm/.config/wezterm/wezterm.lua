local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.window_decorations = "RESIZE" -- 禁用标题栏
config.hide_tab_bar_if_only_one_tab = true

config.window_close_confirmation = "NeverPrompt" -- 禁用窗口关闭提示

config.window_background_opacity = 0.9
config.tab_bar_at_bottom = true
config.enable_tab_bar = true

config.color_scheme = "Gruvbox Material (Gogh)"

-- Ⅳa
config.font = wezterm.font_with_fallback({
	{ family = "JetBrainsMono Nerd Font" },
	{ family = "Maple Mono SC NF" },
	{ family = "Iosevka Term" },
})

config.font_size = 14
config.line_height = 1.1

config.window_padding = {
	left = 8,
	right = 8,
	top = 8,
	bottom = 8,
}

require("keymaps").setup(config)
require("launch").setup(config)
require("tabs")

return config
