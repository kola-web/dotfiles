local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

local servers = {
	"cssls",
	"cssmodules_ls",
	"emmet_ls",
	"html",
	"jsonls",
	"sumneko_lua",
	"tsserver",
	"yamlls",
	"bashls",
	"volar",
	"bashls",
}

for _, lsp in ipairs(servers) do
	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
		root_dir = vim.loop.cwd,
	}
	if servers == "emmet_ls" then
		opts.filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "vue" }
	end
	if servers == "tsserver" then
		opts.filetypes = { "typescript", "typescriptreact", "typescript.tsx" }
	end
	lspconfig[lsp].setup(opts)
end
