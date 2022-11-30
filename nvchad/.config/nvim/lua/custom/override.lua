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
		"prettierd",
		"eslint",
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
		{
			name = "nvim_lsp",
			entry_filter = function(entry, ctx)
				local kind = require("cmp.types").lsp.CompletionItemKind[entry:get_kind()]
				if kind == "Snippet" and ctx.prev_context.filetype == "java" then
					return false
				end
				if kind == "Text" then
					return false
				end
				return true
			end,
		},
		{ name = "path" },
		{ name = "luasnip" },
		{ name = "nvim_lua" },
		{ name = "buffer" },
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