local null_servers = {
	"eslint",
	"prettier",
	"stylua",
	"editorconfig_checker",
}

local servers = {
	"bashls",
	"clangd",
	"cssls",
	"emmet_ls",
	"html",
	"jsonls",
	"tsserver",
	"sumneko_lua",
	"zk",
	"volar",
	"yamlls",
}

local settings = {
	ensure_installed = null_servers,
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
	automatic_setup = true,
})
require("mason-null-ls").setup({
	ensure_installed = null_servers,
	automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = on_attach,
		capabilities = capabilities,
		-- root_dir = vim.loop.cwd,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end
