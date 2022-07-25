-- lua/custom/mappings
local M = {}

-- add this table only when you want to disable default keys
M.disabled = {
	n = {
		["<C-n>"] = "",
		["<C-h>"] = "",
		["<C-j>"] = "",
		["<C-k>"] = "",
		["<C-l>"] = "",
		["<leader>x"] = "",
		-- telescope
		["<leader>ff"] = "",
		["<leader>fa"] = "",
		["<leader>fw"] = "",
		["<leader>fb"] = "",
		["<leader>fh"] = "",
		["<leader>fo"] = "",
		["<leader>tk"] = "",
		["<leader>cm"] = "",
		["<leader>gt"] = "",
		["<leader>pt"] = "",
		["<leader>th"] = "",
		-- lspconfig
		["<leader>ls"] = "",
		["<leader>D"] = "",
		["<leader>ra"] = "",
		["<leader>ca"] = "",
		["<leader>q"] = "",
		["<leader>fm"] = "",
		["<leader>wa"] = "",
		["<leader>wr"] = "",
		["<leader>wl"] = "",
		-- nvterm
		["<leader>h"] = "",
		["<leader>v"] = "",
		["<A-i>"] = "",
		["<A-h>"] = "",
		["<A-v>"] = "",
		-- which-key
		["<leader>wK"] = "",
		["<leader>wk"] = "",
		-- blankline
		["<leader>bc"] = "",
	},
	t = {
		["<A-i>"] = "",
		["<A-h>"] = "",
		["<A-v>"] = "",
	},
}

M.general = {
	n = {
		["<S-l>"] = { "$", "$" },
		["<S-h>"] = { "^", "^" },
		["<leader>w"] = { "<cmd> w <CR>", "﬚  save file" },
		["<leader>h"] = { "<cmd> nohlsearch <CR>" },
	},
	v = {
		["<S-l>"] = { "$", "$" },
		["<S-h>"] = { "^", "^" },
		["<"] = { "<gv", "<" },
		[">"] = { ">gv", "<" },
	},
}

M.substitute = {
	n = {
		["s"] = { "<cmd>lua require('substitute').operator()<cr>", "substitute", opts = { noremap = true } },
		["ss"] = { "<cmd>lua require('substitute').line()<cr>", "substitute", opts = { noremap = true } },
		["S"] = { "<cmd>lua require('substitute').eol()<cr>", "substitute", opts = { noremap = true } },
		-- ["sx"] = {  "<cmd>lua require('substitute.exchange').operator()<cr>", "substitute", opts = { noremap = true }},
		-- ["sxx"] = {  "<cmd>lua require('substitute.exchange').line()<cr>", "substitute", opts = { noremap = true }},
		-- ["sxc"] = {  "<cmd>lua require('substitute.exchange').cancel()<cr>", "substitute", opts = { noremap = true }},
	},
	x = {
		["s"] = { "<cmd>lua require('substitute').visual()<cr>", "substitute", opts = { noremap = true } },
		-- ["X"] = {  "<cmd>lua require('substitute.exchange').line()<cr>", "substitute", opts = { noremap = true }},
	},
}

M.lspconfig = {
	-- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

	n = {
		["gD"] = {
			function()
				vim.lsp.buf.declaration()
			end,
			"   lsp declaration",
		},

		["gd"] = {
			function()
				vim.lsp.buf.definition()
			end,
			"   lsp definition",
		},

		["K"] = {
			function()
				vim.lsp.buf.hover()
			end,
			"   lsp hover",
		},

		["gi"] = {
			function()
				vim.lsp.buf.implementation()
			end,
			"   lsp implementation",
		},

		["<leader>a"] = {
			function()
				vim.lsp.buf.code_action()
			end,
			"   lsp code_action",
		},
		["gr"] = {
			function()
				vim.lsp.buf.references()
			end,
			"   lsp references",
		},
		["[d"] = {
			function()
				vim.diagnostic.goto_prev()
			end,
			"   goto prev",
		},
		["d]"] = {
			function()
				vim.diagnostic.goto_next()
			end,
			"   goto_next",
		},
		["<leader>m"] = {
			function()
				vim.lsp.buf.formatting()
			end,
			"   lsp formatting",
		},
	},
}

M.tabufline = {

	n = {
		-- new buffer
		["<S-b>"] = { "<cmd> enew <CR>", "烙 new buffer" },

		-- cycle through buffers
		["<TAB>"] = { "<cmd> Tbufnext <CR>", "  goto next buffer" },
		["<S-Tab>"] = { "<cmd> Tbufprev <CR> ", "  goto prev buffer" },

		-- cycle through tabs
		["<leader>tp"] = { "<cmd> tabprevious <CR>", "  goto next tab" },
		["<leader>tn"] = { "<cmd> tabnext <CR> ", "  goto prev tab" },

		-- close buffer + hide terminal buffer
		["<leader>c"] = {
			function()
				require("core.utils").close_buffer()
			end,
			"   close buffer",
		},
	},
}

M.telescope = {
	n = {
		-- find
		["<leader>f"] = { "<cmd> Telescope find_files <CR>", "  find files" },
		["<leader>sa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "  find all" },
		["<leader>sw"] = { "<cmd> Telescope live_grep <CR>", "   live grep" },
		["<leader>sb"] = { "<cmd> Telescope buffers <CR>", "  find buffers" },
		["<leader>sh"] = { "<cmd> Telescope help_tags <CR>", "  help page" },
		["<leader>so"] = { "<cmd> Telescope oldfiles <CR>", "   find oldfiles" },
		["<leader>sk"] = { "<cmd> Telescope keymaps <CR>", "   show keys" },

		-- git
		["<leader>sm"] = { "<cmd> Telescope git_commits <CR>", "   git commits" },
		["<leader>st"] = { "<cmd> Telescope git_status <CR>", "  git status" },

		-- pick a hidden term
		["<leader>s'"] = { "<cmd> Telescope terms <CR>", "   pick hidden term" },

		-- theme switcher
		["<leader>sc"] = { "<cmd> Telescope themes <CR>", "   nvchad themes" },
	},
}

M.tmux = {
	n = {
		["<C-left>"] = { "<cmd>lua require('tmux').resize_left()<cr>", "resize-left", opts = { noremap = true } },
		["<C-up>"] = { "<cmd>lua require('tmux').resize_top()<cr>", "resize-top", opts = { noremap = true } },
		["<C-down>"] = { "<cmd>lua require('tmux').resize_bottom()<cr>", "resize-botton", opts = { noremap = true } },
		["<C-right>"] = { "<cmd>lua require('tmux').resize_right()<cr>", "resize-right", opts = { noremap = true } },
	},
}

return M
