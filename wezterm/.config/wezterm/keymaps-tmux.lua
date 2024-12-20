local wezterm = require("wezterm")
local act = wezterm.action

return {
	{
		key = "t",
		mods = "CMD",
		action = act.Multiple({
			act.SendKey({ key = "b", mods = "CTRL" }),
			act.SendKey({ key = "c" }),
		}),
	},
	{
		key = "d",
		mods = "CMD",
		action = act.Multiple({
			act.SendKey({ key = "b", mods = "CTRL" }),
			act.SendKey({ key = "%" }),
		}),
	},
	{
		key = "D",
		mods = "CMD",
		action = act.Multiple({
			act.SendKey({ key = "b", mods = "CTRL" }),
			act.SendKey({ key = '"' }),
		}),
	},
	{
		key = "w",
		mods = "CMD",
		action = act.Multiple({
			act.SendKey({ key = "b", mods = "CTRL" }),
			act.SendKey({ key = "x" }),
		}),
	},
	{
		key = "u",
		mods = "CMD",
		action = act.Multiple({
			act.SendKey({ key = "b", mods = "CTRL" }),
			act.SendKey({ key = "u" }),
		}),
	},
	{
		key = "[",
		mods = "CMD",
		action = act.Multiple({
			act.SendKey({ key = "b", mods = "CTRL" }),
			act.SendKey({ key = "[" }),
		}),
	},
	{
		key = "]",
		mods = "CMD",
		action = act.Multiple({
			act.SendKey({ key = "b", mods = "CTRL" }),
			act.SendKey({ key = "]" }),
		}),
	},
	{
		key = "1",
		mods = "CMD",
		action = act.Multiple({
			act.SendKey({ key = "b", mods = "CTRL" }),
			act.SendKey({ key = "1" }),
		}),
	},
	{
		key = "2",
		mods = "CMD",
		action = act.Multiple({
			act.SendKey({ key = "b", mods = "CTRL" }),
			act.SendKey({ key = "2" }),
		}),
	},
	{
		key = "3",
		mods = "CMD",
		action = act.Multiple({
			act.SendKey({ key = "b", mods = "CTRL" }),
			act.SendKey({ key = "3" }),
		}),
	},
	{
		key = "4",
		mods = "CMD",
		action = act.Multiple({
			act.SendKey({ key = "b", mods = "CTRL" }),
			act.SendKey({ key = "4" }),
		}),
	},
	{
		key = "5",
		mods = "CMD",
		action = act.Multiple({
			act.SendKey({ key = "b", mods = "CTRL" }),
			act.SendKey({ key = "5" }),
		}),
	},
	{
		key = "6",
		mods = "CMD",
		action = act.Multiple({
			act.SendKey({ key = "b", mods = "CTRL" }),
			act.SendKey({ key = "6" }),
		}),
	},
	{
		key = "7",
		mods = "CMD",
		action = act.Multiple({
			act.SendKey({ key = "b", mods = "CTRL" }),
			act.SendKey({ key = "7" }),
		}),
	},
	{
		key = "8",
		mods = "CMD",
		action = act.Multiple({
			act.SendKey({ key = "b", mods = "CTRL" }),
			act.SendKey({ key = "8" }),
		}),
	},
	{
		key = "9",
		mods = "CMD",
		action = act.Multiple({
			act.SendKey({ key = "b", mods = "CTRL" }),
			act.SendKey({ key = "9" }),
		}),
	},
	{
		key = ".",
		mods = "CMD",
		action = wezterm.action.ReloadConfiguration,
	},
}
