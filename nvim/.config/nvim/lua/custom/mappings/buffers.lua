local M = {}

function moveAllEleTest(originTbl, n)
	if type(originTbl) ~= "table" then
		return
	end
	if #originTbl == 0 then
		return
	end

	local newTbl = {}
	for i = 1, #originTbl do
		newTbl[i] = originTbl[(n - 1 + i) % #originTbl + 1]
	end
	return newTbl
end

M.move_buf_left = function()
	local bufs = vim.t.bufs

	bufs = moveAllEleTest(bufs, 1)

	vim.t.bufs = bufs
	vim.cmd("redrawtabline")
end

M.move_buf_right = function()
	local bufs = vim.t.bufs
	bufs = moveAllEleTest(bufs, -1)

	vim.t.bufs = bufs
	vim.cmd("redrawtabline")
end

return M
