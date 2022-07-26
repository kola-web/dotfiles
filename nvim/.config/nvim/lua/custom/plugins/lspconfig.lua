local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

local servers = {
	"sumneko_lua",
	"emmet_ls",
	"html",
	"cssls",
	"jsonls",
	"tsserver",
	"volar",
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
	if servers == "volar" then
		opts.filetypes = { "vue" }
		opts.init_options = {
			serverPath = "echo "..FNM_MULTISHELL_PATH.."/lib/node_modules/typescript/lib/tsserverlibrary.js",
		}
	end
	lspconfig[lsp].setup(opts)
end
