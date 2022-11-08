local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

local servers = {
	"emmet_ls",
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
		opts.settings = {
			json = {
				schemas = vim.list_extend({
					{
						fileMatch = { "app.json" },
						url = "https://dldir1.qq.com/WechatWebDev/editor-extension/wx-json/app.schema.json",
					},

					{
						fileMatch = { "ext.json" },
						url = "https://dldir1.qq.com/WechatWebDev/editor-extension/wx-json/ext.schema.json",
					},
					{
						fileMatch = { "game.json" },
						url = "https://dldir1.qq.com/WechatWebDev/editor-extension/wx-json/game.schema.json",
					},
					{
						fileMatch = { "plugin.json" },
						url = "https://dldir1.qq.com/WechatWebDev/editor-extension/wx-json/plugin.schema.json",
					},
					{
						fileMatch = { "project.config.json" },
						url = "https://dldir1.qq.com/WechatWebDev/editor-extension/wx-json/project.config.schema.json",
					},
					{
						fileMatch = { "project.private.config.json" },
						url = "https://dldir1.qq.com/WechatWebDev/editor-extension/wx-json/project.private.config.schema.json",
					},
					{
						fileMatch = { "sitemap.json" },
						url = "https://dldir1.qq.com/WechatWebDev/editor-extension/wx-json/sitemap.schema.json",
					},
					{
						fileMatch = { "container.config.json" },
						url = "https://dldir1.qq.com/WechatWebDev/editor-extension/wx-json/container.config.schema.json",
					},
					{
						fileMatch = { "androidPrivacy.json" },
						url = "https://raw.githubusercontent.com/ModyQyW/uni-helper/main/packages/vscode-uni-app-schemas/schemas/androidPrivacy.json",
					},
					{
						fileMatch = { "manifest.json" },
						url = "https://raw.githubusercontent.com/ModyQyW/uni-helper/main/packages/vscode-uni-app-schemas/schemas/manifest.json",
					},
					{
						fileMatch = { "pages.json" },
						url = "https://raw.githubusercontent.com/ModyQyW/uni-helper/main/packages/vscode-uni-app-schemas/schemas/pages.json",
					},
					{
						fileMatch = {
							"*.json",
							"!/settings.json",
							"!/config.json",
							"!/app.json",
							"!/ext.json",
							"!/game.json",
							"!/plugin.json",
							"!/project.config.json",
							"!/sitemap.json",
							"!/container.config.json",
							"!/.eslintrc.*",
							"!project.private.config.json",
							"!keybindings.json",
						},
						url = "https://dldir1.qq.com/WechatWebDev/plugins/editor/wechat-miniprogram_wx-json/1.0.0/page_component.schema.json",
					},
				}, require("schemastore").json.schemas()),
				validate = { enable = true },
			},
		}
	end

	lspconfig[lsp].setup(opts)
end
