local M = {}
local wezterm = require("wezterm")
local act = wezterm.action

-- if you are *NOT* lazy-loading smart-splits.nvim (recommended)
local function is_vim(pane)
	-- this is set by the plugin, and unset on ExitPre in Neovim
	return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
	Left = "h",
	Down = "j",
	Up = "k",
	Right = "l",
	-- reverse lookup
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

M.keys = {
	-- move between split panes
	split_nav("move", "h"),
	split_nav("move", "j"),
	split_nav("move", "k"),
	split_nav("move", "l"),
	-- resize panes
	split_nav("resize", "h"),
	split_nav("resize", "j"),
	split_nav("resize", "k"),
	split_nav("resize", "l"),

	{
		key = "q",
		mods = "CMD",
		action = act.QuitApplication,
	},

	{
		key = "c",
		mods = "CMD",
		action = act.CopyTo("Clipboard"),
	},
	{
		key = "v",
		mods = "CMD",
		action = act.PasteFrom("Clipboard"),
	},

	{
		key = "t",
		mods = "CMD",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "D",
		mods = "CMD",
		action = act.SplitVertical,
	},
	{
		key = "d",
		mods = "CMD",
		action = act.SplitHorizontal,
	},
	{
		key = "w",
		mods = "CMD",
		action = act.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "z",
		mods = "CMD",
		action = act.TogglePaneZoomState,
	},
	{
		key = ".",
		mods = "CMD",
		action = act.ReloadConfiguration,
	},
	{
		key = "[",
		mods = "CMD",
		action = act.MoveTabRelative(-1),
	},
	{
		key = "]",
		mods = "CMD",
		action = act.MoveTabRelative(1),
	},
	{
		key = "1",
		mods = "CMD",
		action = act.ActivateTab(0),
	},
	{
		key = "2",
		mods = "CMD",
		action = act.ActivateTab(1),
	},
	{
		key = "3",
		mods = "CMD",
		action = act.ActivateTab(2),
	},
	{
		key = "4",
		mods = "CMD",
		action = act.ActivateTab(3),
	},
	{
		key = "5",
		mods = "CMD",
		action = act.ActivateTab(4),
	},
	{
		key = "6",
		mods = "CMD",
		action = act.ActivateTab(5),
	},
	{
		key = "7",
		mods = "CMD",
		action = act.ActivateTab(6),
	},
	{
		key = "8",
		mods = "CMD",
		action = act.ActivateTab(7),
	},
	{
		key = "9",
		mods = "CMD",
		action = act.ActivateTab(8),
	},
	{
		key = "0",
		mods = "CMD",
		action = act.ActivateTab(-1),
	},
	{
		key = "P",
		mods = "CMD",
		action = act.ActivateCommandPalette,
	},
	{
		key = " ",
		mods = "CMD",
		action = act.ActivateCopyMode,
	},
	{
		key = "f",
		mods = "CMD",
		action = act.Search({ CaseSensitiveString = "" }),
	},
	{ key = "l", mods = "CMD", action = wezterm.action.ShowDebugOverlay },

	-- fix neovim keybind
	{
		key = "-",
		mods = "CTRL",
		action = act.SendKey({ key = "-", mods = "CTRL" }),
	},
}

M.key_tables = {
	resize_pane = {
		{ key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },

		{ key = "RightArrow", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },

		{ key = "UpArrow", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },

		{ key = "DownArrow", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },

		-- Cancel the mode by pressing escape
		{ key = "Escape", action = "PopKeyTable" },
	},
}

M.setup = function(config)
	config.disable_default_key_bindings = true
	config.keys = M.keys
end

return M
