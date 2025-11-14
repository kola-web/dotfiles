local wezterm = require('wezterm')

local config = wezterm.config_builder()
require('events.window').setup(wezterm)
require('keymaps').setup(config)
require('config.launch').setup(config)
require('config.domains').setup(config)
require('plugins').setup(config)

config.audible_bell = 'Disabled'
config.visual_bell = {
  fade_in_duration_ms = 0,
  fade_out_duration_ms = 0,
}
config.color_scheme = 'Dracula'

config.enable_scroll_bar = true
config.tab_bar_at_bottom = true
config.window_close_confirmation = 'NeverPrompt'

config.font_size = 12
config.font = wezterm.font('Maple Mono NF CN')

config.enable_kitty_keyboard = true

-- Cursor
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_background_opacity = 0.94

return config
