-- Just an example, supposed to be placed in /lua/custom/

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.ui = {
	theme = "gruvchad",
}

M.options = {
	user = function()
		vim.opt.relativenumber = true
		vim.opt.timeoutlen = 1000
	end,
}

M.plugins = {
	user = require("custom.plugins"),
	override = {
		["nvim-treesitter/nvim-treesitter"] = {
			ensure_installed = {
				"lua",
				"html",
				"css",
				"javascript",
				"typescript",
				"vue",
				"json",
			},
			highlight = {
				enable = true,
				use_languagetree = true,
			},
		},
	},
	remove = {
		"NvChad/nvterm",
	},
}

M.mappings = require("custom.mappings")

return M
