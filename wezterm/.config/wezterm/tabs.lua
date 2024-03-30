local wezterm = require("wezterm")

local HOME_DIR = string.format("file://%s", os.getenv("HOME"))

local function get_current_working_dir(tab)
	local current_dir = tostring(tab.active_pane.current_working_dir) or ""
	return current_dir == HOME_DIR and "~" or string.match(current_dir, ".*/([^/]+/[^/]+)$")
end

wezterm.on("format-tab-title", function(tab)
	local tab_index = tab.tab_index + 1
	local current_dir = get_current_working_dir(tab)
	return {
		{ Text = string.format(" %d %s ", tab_index, current_dir) },
	}
end)
