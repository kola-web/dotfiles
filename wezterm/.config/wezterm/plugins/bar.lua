local M = {}

M.setup = function(wezterm, config)
	local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
	tabline.setup({
		options = {
			icons_enabled = true,
			theme = "Kanagawa (Gogh)",
			color_overrides = {},
			section_separators = "",
			component_separators = "",
			tab_separators = "",
		},
		sections = {
			tabline_a = { "mode" },
			tabline_b = { "workspace" },
			tabline_c = { " " },
			tab_active = {
				"tab_index",
				{ "parent", padding = 0 },
				"/",
				{ "cwd", max_length = 20, padding = { left = 0, right = 1 } },
				{ "zoomed", padding = 0 },
			},
			tab_inactive = { "tab_index", { "cwd", padding = { left = 0, right = 1 } } },
			tabline_x = { "ram", "cpu" },
			tabline_y = { "datetime", "battery" },
			tabline_z = { "hostname" },
		},
		extensions = {},
	})

	tabline.apply_to_config(config)
end

return M
