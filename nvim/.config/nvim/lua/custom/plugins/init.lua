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
	["gbprod/substitute.nvim"] = {},
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
}
