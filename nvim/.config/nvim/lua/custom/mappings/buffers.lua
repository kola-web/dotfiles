local M = {}

function moveItemRight(originTbl, n)
	local index = nil
	for k, v in ipairs(originTbl) do
    print(v)
		if v == n then
			index = k
		end
	end
	table.remove(originTbl, index)
	if index == #originTbl + 1 then
		table.insert(originTbl, 1, n)
	else
		table.insert(originTbl, index + 1, n)
	end
  return originTbl
end

function moveItemLeft(originTbl, n)
	local index = nil
	for k, v in ipairs(originTbl) do
		if v == n then
			index = k
		end
	end
	table.remove(originTbl, index)
	if index == 1 then
		table.insert(originTbl, #originTbl + 1, n)
	else
		table.insert(originTbl, index - 1, n)
	end
  return originTbl
end

M.move_buf_left = function()
	local bufs = vim.t.bufs
	bufs = moveItemLeft(bufs, vim.api.nvim_get_current_buf())
	vim.t.bufs = bufs
	vim.cmd("redrawtabline")
end

M.move_buf_right = function()
	local bufs = vim.t.bufs
	bufs = moveItemRight(bufs, vim.api.nvim_get_current_buf())
	vim.t.bufs = bufs
	vim.cmd("redrawtabline")
end

return M
