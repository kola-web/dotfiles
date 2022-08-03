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
	"vuels",
	-- "volar",
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
		opts.init_options = {
			hostInfo = "neovim",
			locale = "zh-cn",
		}
	end
	if servers == "emmet_ls" then
		opts.filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "vue" }
		opts.init_options = {
			html = {
				options = {
					["bem.enabled"] = true,
				},
			},
		}
	end
	if servers == "volar" then
		opts.filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" }
		opts.init_options = {
			typescript = {
				serverPath = os.getenv("FNM_MULTISHELL_PATH") .. "/lib/node_modules/typescript/lib/tsserverlibrary.js",
			},
		}
	end
	lspconfig[lsp].setup(opts)
end
