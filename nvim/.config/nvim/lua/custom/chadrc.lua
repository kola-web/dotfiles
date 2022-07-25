-- Just an example, supposed to be placed in /lua/custom/

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.ui = {
	theme = "gruvchad",
}

M.plugins = {
	user = require("custom.plugins"),
	override = require("custom.override"),
	remove = {
		"NvChad/nvterm",
	},
}

M.mappings = require("custom.mappings")

return M
