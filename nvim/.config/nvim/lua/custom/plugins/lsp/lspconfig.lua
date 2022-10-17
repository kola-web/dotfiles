local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

local servers = {
	"sumneko_lua",
	"yamlls",
	"emmet_ls",
	"html",
	"cssls",
	"jsonls",
	"tsserver",
	"intelephense",
	"dockerls",
	"clangd",
	"marksman",
	--bash
	"bashls",
	-- vue
	"volar",
}

for _, lsp in ipairs(servers) do
	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
		root_dir = vim.loop.cwd,
	}

	if servers == "sumneko_lua" then
		opts.settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		}
	end

	if servers == "tsserver" then
		opts.filetypes = { "typescript", "typescriptreact", "typescript.tsx" }
		opts.init_options = {
			locale = "zh-CN",
		}
	end

	if servers == "emmet_ls" then
		opts.filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "php", "vue" }
	end

	if servers == "jsonls" then
		opts.filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "php" }
		opts.settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
				validate = { enable = true },
			},
		}
	end

	lspconfig[lsp].setup(opts)
end
