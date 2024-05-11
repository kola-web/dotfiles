local M = {}
local wezterm = require("wezterm")

M.setup = function(config)
	local launch_menu = {}
	if wezterm.target_triple == "x86_64-pc-windows-msvc" then
		table.insert(launch_menu, {
			label = "PowerShell",
			args = { "powershell.exe", "-NoLogo" },
		})
	elseif wezterm.target_triple == "aarch64-apple-darwin" then
	end

	config.launch_menu = launch_menu
end

return M
