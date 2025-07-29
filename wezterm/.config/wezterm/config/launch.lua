local platform = require("utils.platform")()
local M = {}

M.setup = function(config)
	-- Set the default shell based on the platform
	if platform.is_win then
		config.default_prog = { "pwsh.exe" }
	end
end

return M
