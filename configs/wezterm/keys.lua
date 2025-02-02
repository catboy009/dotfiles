local wezterm = require("wezterm")

local keys = {}

function keys.setup(config)
	config.disable_default_key_bindings = false
	config.keys = {

		{
			mods = "CMD",
			key = [[\]],
			action = wezterm.action({
				SplitHorizontal = { domain = "CurrentPaneDomain" },
			}),
		},
		{
			mods = "CMD|SHIFT",
			key = [[|]],
			action = wezterm.action.SplitPane({
				top_level = true,
				direction = "Right",
				size = { Percent = 50 },
			}),
		},
		{
			mods = "CMD",
			key = [[-]],
			action = wezterm.action({
				SplitVertical = { domain = "CurrentPaneDomain" },
			}),
		},
		{
			mods = "CMD|SHIFT",
			key = [[_]],
			action = wezterm.action.SplitPane({
				top_level = true,
				direction = "Down",
				size = { Percent = 50 },
			}),
		},
		{
			key = "h",
			mods = "CMD",
			action = wezterm.action.ActivatePaneDirection("Left"),
		},
		{
			key = "l",
			mods = "CMD",
			action = wezterm.action.ActivatePaneDirection("Right"),
		},
		{
			key = "k",
			mods = "CMD",
			action = wezterm.action.ActivatePaneDirection("Up"),
		},
		{
			key = "j",
			mods = "CMD",
			action = wezterm.action.ActivatePaneDirection("Down"),
		},

		{
			key = "h",
			mods = "CMD|SHIFT",
			action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
		},
		{
			key = "l",
			mods = "CMD|SHIFT",
			action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
		},
		{
			key = "k",
			mods = "CMD|SHIFT",
			action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
		},
		{
			key = "j",
			mods = "CMD|SHIFT",
			action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
		},
		{ key = "z", mods = "CMD", action = wezterm.action.TogglePaneZoomState },
		{ key = "w", mods = "CMD", action = wezterm.action.CloseCurrentPane({ confirm = false }) },

		{ key = "[", mods = "CMD", action = wezterm.action({ ActivateTabRelative = -1 }) },
		{ key = "]", mods = "CMD", action = wezterm.action({ ActivateTabRelative = 1 }) },

		{ key = "y", mods = "CMD", action = wezterm.action.ActivateCopyMode },

		{ key = "1", mods = "CMD", action = wezterm.action({ ActivateTab = 0 }) },
		{ key = "2", mods = "CMD", action = wezterm.action({ ActivateTab = 1 }) },
		{ key = "3", mods = "CMD", action = wezterm.action({ ActivateTab = 2 }) },
		{ key = "4", mods = "CMD", action = wezterm.action({ ActivateTab = 3 }) },
		{ key = "5", mods = "CMD", action = wezterm.action({ ActivateTab = 4 }) },
		{ key = "6", mods = "CMD", action = wezterm.action({ ActivateTab = 5 }) },
		{ key = "7", mods = "CMD", action = wezterm.action({ ActivateTab = 6 }) },
		{ key = "8", mods = "CMD", action = wezterm.action({ ActivateTab = 7 }) },
		{ key = "9", mods = "CMD", action = wezterm.action({ ActivateTab = 8 }) },
	}
end

return keys
