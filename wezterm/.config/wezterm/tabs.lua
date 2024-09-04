local M = {}
M.arrow_solid = ""
M.arrow_thin = ""

function M.setup(config)
	config.use_fancy_tab_bar = false
	config.tab_bar_at_bottom = true
	config.hide_tab_bar_if_only_one_tab = true
	config.tab_max_width = 32
	config.unzoom_on_switch_pane = true
end

return M
