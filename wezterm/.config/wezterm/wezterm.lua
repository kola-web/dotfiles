local wezterm = require("wezterm")
local keymaps = require("keymaps")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.default_gui_startup_args = { "connect", "unix" }

config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.tab_bar_at_bottom = true

config.color_scheme = "Gruvbox Material (Gogh)"

config.font = wezterm.font("JetBrainsMono Nerd Font")

config.font_size = 14
config.front_end = "WebGpu"
config.line_height = 1.4

config.keys = keymaps

return config
