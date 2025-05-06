local M = {}

M.setup = function(wezterm)
  local mux = wezterm.mux
  wezterm.on("gui-startup", function()
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
  end)
end

return M
