local wezterm = require("wezterm")
local mux = wezterm.mux

wezterm.on("window-config-reloaded", function(window, pane)
	window:toast_notification("Configuration loaded.", "", nil, 5000)
end)

-- wezterm.on("gui-startup", function(cmd)
-- 	local tab, pane, window = mux.spawn_window(cmd or {})
-- 	local newPane = pane:split({ size = 0.5 })
-- 	pane:split({ direction = "Bottom", size = 0.5 })
-- 	newPane:split({ direction = "Bottom", size = 0.5 })
-- end)

