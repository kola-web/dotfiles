require("custom.options")
require("custom.filetype")

vim.g.luasnippets_path = "~/.config/nvim/lua/custom/snippets"

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



local has = function(x)
  return vim.fn.has(x) == 1
end

local is_win = has "win32"
local is_wsl = has "wsl"
local is_mac = has "macunix"
local is_linux = has "linux"

if is_linux then
  require('custom.linux')
end
