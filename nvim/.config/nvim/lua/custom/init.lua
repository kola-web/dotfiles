require("custom.options")
require("custom.filetype")
require("custom.transparent")
require("custom.autocmds")

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
	vim.g.luasnippets_path = "~/.config/nvim/lua/custom/snippets"
end
