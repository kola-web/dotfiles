local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Support for undercurl, etc.
-- config.term = "wezterm"

config.default_prog = { "/bin/zsh", "-l" }
config.window_decorations = "RESIZE"

config.window_close_confirmation = "AlwaysPrompt"
config.tab_bar_at_bottom = true
config.tab_max_width = 40
config.enable_tab_bar = true

config.color_scheme = "Gruvbox Material (Gogh)"

config.window_background_opacity = 0.94

-- config.font = wezterm.font_with_fallback({
-- 	"JetBrains Mono",
--   "Iosevka"
-- })

config.font = wezterm.font("JetBrainsMonoNL Nerd Font Mono")
config.font_rules = {
	{
		italic = true,
		font = wezterm.font("JetBrainsMonoNL Nerd Font Mono", { weight = "Bold", italic = true }),
	},
}
config.font_size = 14
config.line_height = 1.4

config.adjust_window_size_when_changing_font_size = true
config.native_macos_fullscreen_mode = true
config.warn_about_missing_glyphs = false
config.window_close_confirmation = "NeverPrompt"

config.freetype_load_flags = "NO_HINTING"
config.front_end = "WebGpu"

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.hyperlink_rules = wezterm.default_hyperlink_rules()

require("keymaps").setup(config)
require("tabs")

return config
