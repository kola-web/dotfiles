require("custom.options")
require("custom.filetype")

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

vim.g.luasnippets_path = "~/.config/nvim.bak/vscodesinps"

