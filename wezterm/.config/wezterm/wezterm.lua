local wezterm = require("wezterm")
local platform = require("utils.platform")()

local config = wezterm.config_builder()
require("keymaps").setup(config)
require("launch").setup(config)
-- require("plugins").setup(config)

config.color_scheme = "Gruvbox Material (Gogh)"

config.enable_scroll_bar = true
config.tab_bar_at_bottom = true
config.window_close_confirmation = "NeverPrompt"
config.font_size = 12
config.font = wezterm.font("Maple Mono NF CN")

-- Cursor
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_background_opacity = 0.94

if platform.is_win then
	config.default_prog = { "pwsh" }
	config.window_decorations = "RESIZE|TITLE"
else
	config.window_decorations = "RESIZE"
end

return config
