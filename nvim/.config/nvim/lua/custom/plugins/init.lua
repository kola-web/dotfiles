-- custom/plugins/init.lua has to return a table
-- THe plugin name is github user or organization name/reponame

return {
	["mg979/vim-visual-multi"] = {},
	["kola-web/vim-indent-object"] = {},
	["kana/vim-textobj-user"] = {},
	["whatyouhide/vim-textobj-xmlattr"] = {},
	["kana/vim-textobj-entire"] = {},
	["wellle/targets.vim"] = {},
	["tpope/vim-repeat"] = {},
	["tpope/vim-surround"] = {},
	["gbprod/substitute.nvim"] = {
		config = function()
			require("custom.plugins.substitute")
		end,
	},
	["aserowy/tmux.nvim"] = {
		config = function()
			require("custom.plugins.tmux")
		end,
	},
	["jose-elias-alvarez/null-ls.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require("custom.plugins.null-ls")
		end,
	},
	["neovim/nvim-lspconfig"] = {
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.plugins.lspconfig")
		end,
	},
	["tzachar/cmp-tabnine"] = {
		run = "./install.sh",
		requires = "hrsh7th/nvim-cmp",
		config = function()
			require("custom.plugins.tabnine")
		end,
	},

	["folke/which-key.nvim"] = {
		module = "which-key",
		disable = false,
		config = function()
			require("custom.mappings.which-key")
		end,
	},

	["chentoast/marks.nvim"] = {
		config = function()
			require("custom.plugins.marks")
		end,
	},

	["windwp/nvim-ts-autotag"] = {
		ft = { "html", "javascriptreact" },
		after = "nvim-treesitter",
		config = function()
			require("custom.plugins.autotag")
		end,
	},

	["michaelb/sniprun"] = {
		run = "bash ./install.sh",
	},

	["johmsalas/text-case.nvim"] = {
		config = function()
			require("custom.plugins.textcase")
		end,
	},

	["nvim-treesitter/playground"] = {
		cmd = "TSCaptureUnderCursor",
		config = function()
			require("nvim-treesitter.configs").setup()
		end,
	},
}
