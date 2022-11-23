local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

local servers = {
	-- "emmet_ls",
	"html",
	"tsserver",
	"jsonls",
	"sumneko_lua",
	"yamlls",
	"dockerls",
	"sourcekit",
	"bashls",
	"volar",
	"zk",
	"intelephense",
}

for _, lsp in ipairs(servers) do
	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
		root_dir = vim.loop.cwd,
	}

	if lsp == "sumneko_lua" then
		opts.settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		}
	end

	if lsp == "tsserver" then
		opts.init_options = {
			locale = "zh-CN",
		}
	end

	if lsp == "emmet_ls" then
		opts.filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "vue" }
	end

	if lsp == "volar" then
		local volar = require("custom.plugins.lsp.volar")
		opts = vim.tbl_deep_extend("force", volar, opts)
	end

	if lsp == "jsonls" then
		local json = require("custom.plugins.lsp.json")
		opts = vim.tbl_deep_extend("force", json, opts)
	end

	lspconfig[lsp].setup(opts)
end
