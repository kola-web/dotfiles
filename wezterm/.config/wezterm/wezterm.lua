-- Pull in the wezterm API
local wezterm = require("wezterm")
local keymaps = require("keymaps")
local keymapsTmux = require("keymaps-tmux")

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
-- config.underline_position = "-4pt"

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Gruvbox Material (Gogh)"
-- config.color_scheme = "Solarized Dark (Gogh)"
-- config.color_scheme = "Catppuccin Mocha"

config.font = wezterm.font("JetBrainsMono Nerd Font")

config.font_size = 14
config.front_end = "WebGpu"
config.line_height = 1.4

config.unix_domains = {
	{
		name = "unix",
	},
}
config.default_gui_startup_args = { "connect", "unix" }

config.keys = keymaps

-- config.keys = keymapsTmux
-- config.enable_tab_bar = false
-- config.hide_tab_bar_if_only_one_tab = true

return config
