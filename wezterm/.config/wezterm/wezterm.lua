local wezterm = require("wezterm")
local platform = require("utils.platform")()
local config = wezterm.config_builder()

wezterm.log_info("reloading")

require("events.right-status").setup()
require("events.left-status").setup()
require("events.tab-title").setup()
require("events.new-tab-button").setup()

require("keymaps").setup(config)
require("launch").setup(config)

config.color_scheme = "Catppuccin Macchiato"

config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

config.enable_scroll_bar = true

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 32
config.show_tab_index_in_tab_bar = false
config.switch_to_last_active_tab_when_closing_tab = true

config.window_close_confirmation = "NeverPrompt"

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 14
config.line_height = 1.2

-- Cursor
config.default_cursor_style = "BlinkingBar"
config.force_reverse_video_cursor = true
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
