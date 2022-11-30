local status_ok, substitute = pcall(require, "substitute")
if not status_ok then
	return
end

substitute.setup({
	on_substitute = nil,
	yank_substituted_text = false,
	range = {
		prefix = "s",
		prompt_current_text = false,
		confirm = false,
		complete_word = false,
		motion1 = false,
		motion2 = false,
		suffix = "",
	},
	exchange = {
		motion = true,
	},
})
