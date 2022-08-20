require("custom.options")
require("custom.filetype")

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

-- autocmds
-- pretty up norg ft!
autocmd("FileType", {
	pattern = "norg",
	callback = function() end,
})

-- vim.g.luasnippets_path = "./vscodeSnipes/package.json"
-- require("luasnip.loaders.from_vscode").load({ include = { "vue" } })
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./vscodeSnipes" } })
print(1)




