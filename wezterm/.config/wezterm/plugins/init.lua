local wezterm = require("wezterm")
local M = {}

M.setup = function(config)
	require("plugins.bar").setup(wezterm, config)
end

return M
