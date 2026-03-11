local wezterm = require('wezterm')

local config = wezterm.config_builder()

-- 加载按键配置（保留原有配置）
require('keymaps').setup(config)

-- ==================== 外观配置 ====================

-- 颜色主题
config.color_scheme = 'GruvboxDark'

-- 字体配置
config.font = wezterm.font('Maple Mono NF CN')
config.font_size = 12

-- 窗口配置
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_background_opacity = 0.94
config.window_decorations = 'RESIZE'
config.window_close_confirmation = 'NeverPrompt'

-- 标签栏配置
config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.enable_scroll_bar = true

-- 光标配置
config.cursor_blink_rate = 500
config.default_cursor_style = 'BlinkingBlock'

-- ==================== 性能优化 ====================

-- 渲染设置
config.front_end = 'WebGpu'
config.webgpu_power_preference = 'HighPerformance'
config.max_fps = 60
config.animation_fps = 60

-- 禁用不必要的视觉效果
config.window_decorations = 'RESIZE'
config.use_resize_increments = false

-- 光标设置（禁用闪烁减少重绘）
config.cursor_blink_rate = 0
config.default_cursor_style = 'SteadyBlock'

-- 滚动缓冲区优化
config.scrollback_lines = 5000

-- 输入输出优化
config.mux_output_parser_coalesce_delay_ms = 1

-- 禁用不必要的功能
config.check_for_updates = false

-- 减少内存占用
config.inactive_pane_hsb = {
  saturation = 1.0,
  brightness = 1.0,
}

-- ==================== 行为配置 ====================

-- 禁用默认按键（由 keymaps.lua 接管）
config.disable_default_key_bindings = true

-- 启用 Kitty 键盘协议
config.enable_kitty_keyboard = true

-- 禁用声音提示
config.audible_bell = 'Disabled'
config.visual_bell = {
  fade_in_duration_ms = 0,
  fade_out_duration_ms = 0,
}

-- 启动时最大化窗口
wezterm.on('gui-startup', function()
  local tab, pane, window = wezterm.mux.spawn_window({})
  window:gui_window():maximize()
end)

-- ==================== Shell 配置 ====================

-- 设置默认 shell（Windows 优先使用 PowerShell 7）
if wezterm.target_triple:find('windows') then
  config.default_prog = { 'pwsh.exe', '-NoLogo' }

  -- 启动菜单
  config.launch_menu = {
    { label = 'PowerShell 7',       args = { 'pwsh.exe', '-NoLogo' } },
    { label = 'Windows PowerShell', args = { 'powershell.exe', '-NoLogo' } },
    { label = 'Command Prompt',     args = { 'cmd.exe' } },
    { label = 'WSL Ubuntu-24.04',   args = { 'wsl.exe', '-d', 'Ubuntu-24.04' } },
  }

  -- WSL 域配置
  config.wsl_domains = {
    {
      name = 'WSL:Ubuntu-24.04',
      distribution = 'Ubuntu-24.04',
    },
  }
elseif wezterm.target_triple:find('apple') then
  config.default_prog = { '/bin/zsh', '-l' }
  config.launch_menu = {
    { label = 'Zsh',  args = { '/bin/zsh', '-l' } },
    { label = 'Bash', args = { '/bin/bash', '-l' } },
  }
else
  config.default_prog = { '/bin/bash', '-l' }
  config.launch_menu = {
    { label = 'Bash', args = { '/bin/bash', '-l' } },
    { label = 'Zsh',  args = { '/usr/bin/zsh', '-l' } },
  }
end

return config
