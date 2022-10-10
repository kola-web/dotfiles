local options = {
	relativenumber = true,
	wrap = false,
	backup = false, -- 创建备份文件
	scrolloff = 5, -- minimal number of screen lines to keep above and below the cursor.
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd([[set iskeyword+=-]])
