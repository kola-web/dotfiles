local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = false, -- adds help for motions
			text_objects = false, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "center", -- align columns left, center or right
	},
	ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = false, -- show help message on the command line when the popup is visible
	-- triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	["a"] = { "<cmd>Alpha<cr>", "Alpha" },
	["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
	["w"] = { "<cmd>w!<CR>", "Save" },
	["q"] = { "<cmd>q!<CR>", "Quit" },
	-- ["c"] = { "<cmd>bd<CR>", "Close Buffer" },
	["c"] = {
		function()
			require("nvchad_ui.tabufline").close_buffer()
		end,
		"Close Buffer",
	},
	["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
	["o"] = { "<cmd>Telescope lsp_document_symbols<CR>", "Symbols" },
	["R"] = { '<cmd>lua require("renamer").rename()<cr>', "Rename" },
	["/"] = { '<cmd>lua require("Comment.api").toggle.linewise.current()<cr>', "Comment" },
	["f"] = {
		"<cmd> Telescope find_files <CR>",
		"Find files",
	},
	["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
	["m"] = { "<cmd>lua vim.lsp.buf.format { async = true }<cr>", "Format" },
	["z"] = { "<cmd>ZenMode<cr>", "Zen" },
	[";"] = { "<cmd>Trouble<cr>", "Trouble" },

	b = {
		name = "Buffers",
		b = {
			"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
			"Buffers",
		},
		o = {
			"<cmd>BufferLineCloseLeft<cr><cmd>BufferLineCloseRight<cr>",
			"closeOtherBuffer",
		},
		j = { "<cmd>BufferLinePick<cr>", "Jump" },
		c = {
			"<cmd>BufferLinePickClose<cr>",
			"Pick which buffer to close",
		},
		h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
		l = {
			"<cmd>BufferLineCloseRight<cr>",
			"Close all to the right",
		},
		D = {
			"<cmd>BufferLineSortByDirectory<cr>",
			"Sort by directory",
		},
		L = {
			"<cmd>BufferLineSortByExtension<cr>",
			"Sort by language",
		},
	},

	p = {
		name = "Projects",
		p = { "<cmd>Telescope oldfiles<cr>", "history file" },
	},

	P = {
		name = "Packer",
		c = { "<cmd>PackerCompile<cr>", "Compile" },
		i = { "<cmd>PackerInstall<cr>", "Install" },
		s = { "<cmd>PackerSync<cr>", "Sync" },
		S = { "<cmd>PackerStatus<cr>", "Status" },
		u = { "<cmd>PackerUpdate<cr>", "Update" },
	},

	r = {
		name = "Replace",
		r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
		w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
		f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
		d = { "<cmd>%s/div/view/g<cr>", "Node" },
	},

	g = {
		name = "Git",
		g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		l = { "<cmd>GitBlameToggle<cr>", "Blame" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"Diff",
		},
		G = {
			name = "Gist",
			a = { "<cmd>Gist -b -a<cr>", "Create Anon" },
			d = { "<cmd>Gist -d<cr>", "Delete" },
			f = { "<cmd>Gist -f<cr>", "Fork" },
			g = { "<cmd>Gist -b<cr>", "Create" },
			l = { "<cmd>Gist -l<cr>", "List" },
			p = { "<cmd>Gist -b -p<cr>", "Create Private" },
		},
	},

	l = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		e = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Errors" },
		n = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Netx Errors" },
		p = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Errors" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		s = { "<cmd>lua Lspsaga signature_help()<cr>", "signature" },
	},

	s = {
		name = "Search",
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		T = {
			function()
				require("base46").toggle_theme()
			end,
			"Colorscheme",
		},
		t = { "<cmd>TodoTelescope<cr>", "todoList" },
		c = { "<cmd>Telescope themes<cr>", "todoList" },
		h = { "<cmd>Telescope help_tags<cr>", "Help" },
		i = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Media" },
		l = { "<cmd>Telescope resume<cr>", "Last Search" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
	},

	S = {
		name = "SnipRun",
		c = { "<cmd>SnipClose<cr>", "Close" },
		n = { "<cmd>%SnipRun<cr>", "Run File" },
		i = { "<cmd>SnipInfo<cr>", "Info" },
		m = { "<cmd>SnipReplMemoryClean<cr>", "Mem Clean" },
		r = { "<cmd>SnipReset<cr>", "Reset" },
		t = { "<cmd>SnipRunToggle<cr>", "Toggle" },
		x = { "<cmd>SnipTerminate<cr>", "Terminate" },
	},

	t = {
		name = "Terminal",
		["1"] = { ":1ToggleTerm<cr>", "1" },
		["2"] = { ":2ToggleTerm<cr>", "2" },
		["3"] = { ":3ToggleTerm<cr>", "3" },
		["4"] = { ":4ToggleTerm<cr>", "4" },
		n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
		u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
		t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
		T = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
		p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
		f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
		h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
		v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
	},
	u = {
		name = "Update",
		u = { "<cmd> :NvChadUpdate <CR>", "  update nvchad" },
	},
	T = {
		name = "Treesitter",
		h = { "<cmd>TSHighlightCapturesUnderCursor<cr>", "Highlight" },
		p = { "<cmd>TSPlaygroundToggle<cr>", "Playground" },
	},
	[" "] = {
		name = "hop",
		f = { "<cmd>HopChar1<cr>", "HopChar1" },
		l = { "<cmd>HopLine<cr>", "HopLine" },
		i = { "<cmd>HopLineStart<cr>", "HopLineStart" },
		w = { "<cmd>HopWord<cr>", "HopWord" },
		s = { "<cmd>HopPattern<cr>", "HopPattern" },
	},
}

local vopts = {
	mode = "v", -- VISUAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local vmappings = {
	["/"] = { "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", "Comment" },
	s = { "<esc><cmd>'<,'>SnipRun<cr>", "Run range" },
}

local ga_opts = {
	mode = "n", -- NORMAL mode
	prefix = "ga",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local vga_opts = {
	mode = "v", -- NORMAL mode
	prefix = "ga",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local ga_mappings = {
	["u"] = { "<cmd>lua require('textcase').current_word('to_upper_case')<CR>", "to_upper_case" },
	["l"] = { "<cmd>lua require('textcase').current_word('to_lower_case')<CR>", "to_lower_case" },
	["s"] = { "<cmd>lua require('textcase').current_word('to_snake_case')<CR>", "to_snake_case" },
	["d"] = { "<cmd>lua require('textcase').current_word('to_dash_case')<CR>", "to_dash_case" },
	["n"] = { "<cmd>lua require('textcase').current_word('to_constant_case')<CR>", "to_constant_case" },
	["."] = { "<cmd>lua require('textcase').current_word('to_dot_case')<CR>", "to_dot_case" },
	["a"] = { "<cmd>lua require('textcase').current_word('to_phrase_case')<CR>", "to_phrase_case" },
	["c"] = { "<cmd>lua require('textcase').current_word('to_camel_case')<CR>", "to_camel_case" },
	["p"] = { "<cmd>lua require('textcase').current_word('to_pascal_case')<CR>", "to_pascal_case" },
	["t"] = { "<cmd>lua require('textcase').current_word('to_title_case')<CR>", "to_title_case" },
	["f"] = { "<cmd>lua require('textcase').current_word('to_path_case')<CR>", "to_path_case" },
	["o"] = { "<cmd>TextCaseOpenTelescope<CR>", "to_path_case" },
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
which_key.register(ga_mappings, ga_opts)
which_key.register(ga_mappings, vga_opts)
