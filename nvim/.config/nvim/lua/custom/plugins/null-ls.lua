local present, null_ls = pcall(require, "null-ls")

if not present then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local sources = {

	-- webdev stuff
	formatting.prettier,
	formatting.black.with({ extra_args = { "--fast" } }),

	-- Lua
	formatting.stylua,

	-- Shell
	formatting.shfmt,
	diagnostics.shellcheck,
}

null_ls.setup({
	debug = true,
	sources = sources,
})
