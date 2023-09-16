-- Pull in the wezterm API
local wezterm = require("wezterm")
local keymaps = require("keymaps")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.tab_bar_at_bottom = true
config.underline_position = "-4pt"

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Gruvbox Material (Gogh)"
-- config.color_scheme = "Solarized Dark (Gogh)"
-- config.color_scheme = "Catppuccin Mocha"

config.font = wezterm.font("JetBrains Mono")
config.font = wezterm.font_with_fallback({
	"FiraCode Nerd Font",
	"Yuppy Sc",
})

config.font_size = 14
config.line_height = 1.4
config.front_end = "WebGpu"

config.keys = keymaps

return config
