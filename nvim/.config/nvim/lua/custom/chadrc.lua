-- Just an example, supposed to be placed in /lua/custom/

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.ui = {
	theme = "catppuccin", -- default theme
	transparency = false,
	theme_toggle = { "catppuccin", "catppuccin_latte" },
	hl_override = require("custom.highlights"),
}

M.plugins = {
	user = require("custom.plugins"),
	override = require("custom.override"),
	remove = {
		"NvChad/nvterm",
		"folke/which-key.nvim",
	},
}

M.mappings = require("custom.mappings")

return M
