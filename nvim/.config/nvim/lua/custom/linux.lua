-- vim.cmd([[
--   autocmd InsertLeave * :silent !fcitx5-remote -c
--   autocmd BufCreate *  :silent !fcitx5-remote -c
--   autocmd BufEnter *  :silent !fcitx5-remote -c
--   autocmd BufLeave *  :silent !fcitx5-remote -c
-- ]])

-- 在 vim 中自动切换输入法
vim.api.nvim_create_autocmd({ "InsertLeave", "BufCreate", "BufEnter", "BufLeave" }, {
	command = "silent !fcitx5-remote -c",
})
