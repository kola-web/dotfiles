require("custom.options")
require("custom.filetype")

-- vim.g.luasnippets_path = "~/.config/nvim/lua/custom/snippets"

local has = function(x)
	return vim.fn.has(x) == 1
end

local is_win = has("win32")
local is_wsl = has("wsl")
local is_mac = has("macunix")
local is_linux = has("linux")

if is_linux then
	require("custom.linux")
elseif is_mac then
	vim.g.luasnippets_path = "/Users/lijialin/Library/Application Support/Code/User/snippets/"
end


vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Search", timeout = 200 })
	end,
})

