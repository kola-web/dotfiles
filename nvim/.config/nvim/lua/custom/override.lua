local M = {}

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
			glyphs = {
				folder = {
					arrow_closed = "", -- arrow when folder is closed
					arrow_open = "", -- arrow when folder is open
				},
			},
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
		-- "editorconfig-checker",
		"stylua",
		"prettier",
		"eslint",

		-- shell
		"shfmt",
		"shellcheck",

		"clang-format",

		--markdown
		"zk",
	},
}

M["hrsh7th/nvim-cmp"] = {
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	},
}

M["lukas-reineke/indent-blankline.nvim"] = {
	filetype_exclude = {
		"help",
		"terminal",
		"alpha",
		"packer",
		"lspinfo",
		"TelescopePrompt",
		"TelescopeResults",
		"nvchad_cheatsheet",
		"lsp-installer",
		"norg",
		"",
	},
}

return M
