-- lua/custom/mappings
local M = {}

-- add this table only when you want to disable default keys
M.disabled = {
	n = {
		["<C-h>"] = "",
		["<C-j>"] = "",
		["<C-k>"] = "",
		["<C-l>"] = "",
		["<leader>n"] = "",
		["<leader>rn"] = "",
		["<leader>uu"] = "",
		["<leader>tt"] = "",
		--tabufline
		["<leader>tp"] = "",
		["<leader>tn"] = "",
		["<leader>x"] = "",
		--comment
		["<leader>/"] = "",
		-- lspconfig
		["<leader>ls"] = "",
		["<leader>D"] = "",
		["<leader>ra"] = "",
		["<leader>ca"] = "",
		["<leader>f"] = "",
		["<leader>q"] = "",
		["<leader>fm"] = "",
		["<leader>wa"] = "",
		["<leader>wr"] = "",
		["<leader>wl"] = "",
		-- nvimtree
		["<C-n>"] = "",
		["<leader>e"] = "",
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
	v = {
		--comment
		["<leader>/"] = "",
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
		["("] = {
			"<cmd>lua require('custom.mappings.buffers').move_buf_left()<cr>",
			"move_buf_left",
			opts = { noremap = true },
		},
		[")"] = {
			"<cmd>lua require('custom.mappings.buffers').move_buf_right()<cr>",
			"move_buf_left",
			opts = { noremap = true },
		},
		["<F1>"] = {
			"<cmd>e ~/note/<cr>",
			"open-note",
			opts = { noremap = true },
		},
	},
	v = {
		["<S-l>"] = { "$", "$" },
		["<S-h>"] = { "^", "^" },
		["<"] = { "<gv", "<" },
		[">"] = { ">gv", "<" },
		["/"] = { '// y/<c-r>"<cr>', "/" },
	},
	o = {
		["<S-l>"] = { "$", "$" },
		["<S-h>"] = { "^", "^" },
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

M.tmux = {
	n = {
		["<C-left>"] = { "<cmd>lua require('tmux').resize_left()<cr>", "resize-left", opts = { noremap = true } },
		["<C-up>"] = { "<cmd>lua require('tmux').resize_top()<cr>", "resize-top", opts = { noremap = true } },
		["<C-down>"] = { "<cmd>lua require('tmux').resize_bottom()<cr>", "resize-botton", opts = { noremap = true } },
		["<C-right>"] = { "<cmd>lua require('tmux').resize_right()<cr>", "resize-right", opts = { noremap = true } },
	},
}

return M
