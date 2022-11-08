local M = {}

local icons = require("custom.icons")

M["nvim-treesitter/nvim-treesitter"] = {
	ensure_installed = {
		"vim",
		"html",
		"css",
		"javascript",
		"json",
		"toml",
		"markdown",
		"bash",
		"lua",
		"norg",
		"tsx",
		"typescript",
		"vue",
	},
	highlight = {
		enable = true,
		use_languagetree = true,
	},
	matchup = {
		enable = true, -- mandatory, false will disable the whole extension
		disable = {}, -- optional, list of language that will be disabled
		-- [options]
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
		separator_style = "round",
	},
}

M["williamboman/mason.nvim"] = {
	ensure_installed = {
		"editorconfig-checker",
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
		"prettier",
		"eslint_d",

		-- shell
		"bash-language-server",
		"shfmt",
		"shellcheck",

		--yaml
		"yaml-language-server",

		--docker
		"dockerfile-language-server",

		--c
		"sourcery",
		"clang-format",

		--markdown
		"zk",

		--php
		"intelephense",
	},
}

M["hrsh7th/nvim-cmp"] = {
	sources = {
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "nvim_lua" },
		{ name = "path" },
	},
}

M["goolord/alpha-nvim"] = {
	after = "base46",
	disable = false,
	config = function()
		require("plugins.configs.alpha")
	end,
}

return M
