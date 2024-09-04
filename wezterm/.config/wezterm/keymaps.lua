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

local mod = {}

if wezterm.target_triple:find("apple") then
	mod.cmd = "CMD"
else
	mod.cmd = "ALT"
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

	{ key = "F12", mods = "NONE", action = wezterm.action.ShowDebugOverlay },
	{
		key = "q",
		mods = mod.cmd,
		action = act.QuitApplication,
	},

	{
		key = "c",
		mods = mod.cmd,
		action = act.CopyTo("Clipboard"),
	},
	{
		key = "v",
		mods = mod.cmd,
		action = act.PasteFrom("Clipboard"),
	},
	{
		key = "u",
		mods = mod.cmd,
		action = wezterm.action.QuickSelectArgs({
			label = "open url",
			patterns = {
				"\\((https?://\\S+)\\)",
				"\\[(https?://\\S+)\\]",
				"\\{(https?://\\S+)\\}",
				"<(https?://\\S+)>",
				"\\bhttps?://\\S+[)/a-zA-Z0-9-]+",
			},
			action = wezterm.action_callback(function(window, pane)
				local url = window:get_selection_text_for_pane(pane)
				wezterm.log_info("opening: " .. url)
				wezterm.open_with(url)
			end),
		}),
	},
	{
		key = "t",
		mods = mod.cmd,
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "D",
		mods = mod.cmd,
		action = act.SplitVertical,
	},
	{ key = "n", mods = mod.cmd, action = act.SpawnWindow },
	{
		key = "d",
		mods = mod.cmd,
		action = act.SplitHorizontal,
	},
	{
		key = "w",
		mods = mod.cmd,
		action = act.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "z",
		mods = mod.cmd,
		action = act.TogglePaneZoomState,
	},
	{
		key = ".",
		mods = mod.cmd,
		action = act.ReloadConfiguration,
	},
	{
		key = "[",
		mods = mod.cmd,
		action = act.MoveTabRelative(-1),
	},
	{
		key = "]",
		mods = mod.cmd,
		action = act.MoveTabRelative(1),
	},
	{
		key = "1",
		mods = mod.cmd,
		action = act.ActivateTab(0),
	},
	{
		key = "2",
		mods = mod.cmd,
		action = act.ActivateTab(1),
	},
	{
		key = "3",
		mods = mod.cmd,
		action = act.ActivateTab(2),
	},
	{
		key = "4",
		mods = mod.cmd,
		action = act.ActivateTab(3),
	},
	{
		key = "5",
		mods = mod.cmd,
		action = act.ActivateTab(4),
	},
	{
		key = "6",
		mods = mod.cmd,
		action = act.ActivateTab(5),
	},
	{
		key = "7",
		mods = mod.cmd,
		action = act.ActivateTab(6),
	},
	{
		key = "8",
		mods = mod.cmd,
		action = act.ActivateTab(7),
	},
	{
		key = "9",
		mods = mod.cmd,
		action = act.ActivateTab(8),
	},
	{
		key = "0",
		mods = mod.cmd,
		action = act.ActivateTab(-1),
	},
	{
		key = " ",
		mods = mod.cmd,
		action = act.ActivateCopyMode,
	},
	{
		key = "f",
		mods = mod.cmd,
		action = act.Search({ CaseSensitiveString = "" }),
	},
	{
		key = "T",
		mods = mod.cmd,
		action = act.ShowLauncher,
	},
	{
		key = "p",
		mods = mod.cmd,
		action = act.ShowLauncherArgs({ flags = "FUZZY|TABS" }),
	},
	{
		key = "P",
		mods = mod.cmd,
		action = act.ActivateCommandPalette,
	},

	-- fix neovim keybind
	{
		key = "-",
		mods = "CTRL",
		action = act.SendKey({ key = "-", mods = "CTRL" }),
	},

	{
		key = "r",
		mods = mod.cmd,
		action = act.ActivateKeyTable({
			name = "resize_pane",
			one_shot = false,
		}),
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
	config.key_tables = M.key_tables
end

return M
