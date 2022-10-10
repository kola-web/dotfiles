local options = {
	relativenumber = true,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd([[set iskeyword+=-]])
