local wezterm = require("wezterm")
local config = wezterm.config_builder()
wezterm.log_info("reloading")

require("events.right-status").setup()
require("events.left-status").setup()
require("events.tab-title").setup()
require("events.new-tab-button").setup()

require("keymaps").setup(config)
require("tabs").setup(config)

config.font = wezterm.font("JetBrainsMono Nerd Font")

config.font_size = 14
config.bold_brightens_ansi_colors = true
config.color_scheme = "Solarized Dark (Gogh)"
config.line_height = 1.2

-- Cursor
config.default_cursor_style = "BlinkingBar"
config.force_reverse_video_cursor = true
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
-- window_background_opacity = 0.9,
-- cell_width = 0.9,
config.scrollback_lines = 10000

if wezterm.target_triple:find("windows") then
	config.default_prog = { "pwsh" }
	config.window_decorations = "RESIZE|TITLE"
	wezterm.on("gui-startup", function(cmd)
		local screen = wezterm.gui.screens().active
		local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
		local gui = window:gui_window()
		local width = 0.7 * screen.width
		local height = 0.7 * screen.height
		gui:set_inner_size(width, height)
		gui:set_position((screen.width - width) / 2, (screen.height - height) / 2)
	end)
else
	config.window_decorations = "RESIZE"
end

return config
