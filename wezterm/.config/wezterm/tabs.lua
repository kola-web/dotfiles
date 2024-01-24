local wezterm = require("wezterm")

local function get_current_working_dir(tab)
	local current_dir = tab.active_pane.current_working_dir
	local HOME_DIR = string.format("file://%s", os.getenv("HOME"))
	return current_dir == HOME_DIR and "." or string.gsub(current_dir, ".*/([^/]+/[^/]+)$", "%1")
end

wezterm.on("format-tab-title", function(tab)
	return {
		{ Text = " " .. tab.tab_index + 1 .. " " .. get_current_working_dir(tab) .. " " },
	}
end)
