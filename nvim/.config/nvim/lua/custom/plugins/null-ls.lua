local present, null_ls = pcall(require, "null-ls")

if not present then
	return
end

local b = null_ls.builtins

local sources = {

	-- webdev stuff
	-- b.formatting.prettier,
	b.diagnostics.editorconfig_checker,
	b.formatting.prettier,
	b.code_actions.eslint.with({
		diagnostics_format = "[eslint] #{m}\n(#{c})",
	}),
	-- b.diagnostics.editorconfig_checker,

	-- Lua
	b.formatting.stylua,

	-- Shell
	b.formatting.shfmt,
	b.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),

	b.diagnostics.zsh,
}

null_ls.setup({
	debug = true,
	sources = sources,
})
