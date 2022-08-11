local M = {}

local icons = require("custom.icons")

M["nvim-treesitter/nvim-treesitter"] = {
	ensure_installed = {
		"lua",
		"html",
		"css",
		"javascript",
		"typescript",
		"vue",
		"json",
		"vim",
		"markdown",
		"bash",
		"toml",
	},
	highlight = {
		enable = true,
		use_languagetree = true,
	},
}

M["kyazdani42/nvim-tree.lua"] = {
	git = {
		enable = true,
	},

	renderer = {
		highlight_git = true,
		icons = {
			show = {
				git = true,
			},
		},
	},
}

M["nvim-telescope/telescope.nvim"] = {
	extensions_list = { "themes", "terms", "textcase" },
}

M["NvChad/ui"] = {
	tabufline = {
		enable = true,
		lazyload = false,
	},
	statusline = {
		separator_style = "default",
	},
}

M["williamboman/mason.nvim"] = {
	ensure_installed = {
		-- lua stuff
		"lua-language-server",
		"stylua",

		-- web dev
		"css-lsp",
		"html-lsp",
		"typescript-language-server",
		"deno",
		"emmet-ls",
		"json-lsp",
		"vue-language-server",
		"vetur-vls",
		"prettier",
		"eslint_d",

		-- shell
		"shfmt",
		"shellcheck",
	},
}

return M
