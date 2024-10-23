local wezterm = require("wezterm")
local platform = require("utils.platform")()

local config = wezterm.config_builder()
config.color_scheme = "Kanagawa (Gogh)"

wezterm.log_info("reloading")

require("keymaps").setup(config)
require("launch").setup(config)
require("plugins").setup(config)

config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

config.enable_scroll_bar = true

config.tab_bar_at_bottom = true
-- config.use_fancy_tab_bar = false
-- config.tab_max_width = 32
-- config.show_tab_index_in_tab_bar = false
-- config.switch_to_last_active_tab_when_closing_tab = true

config.window_close_confirmation = "NeverPrompt"

config.font = wezterm.font("Cascadia Code NF")
config.font_size = 12
config.line_height = 1.2

-- Cursor
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
-- window_background_opacity = 0.9,
-- cell_width = 0.9,
config.scrollback_lines = 10000

if platform.is_win then
	config.default_prog = { "pwsh" }
	config.window_decorations = "RESIZE|TITLE"
else
	config.window_decorations = "RESIZE"
end

return config
