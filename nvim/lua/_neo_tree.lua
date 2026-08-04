local ok, neotree = pcall(require, "neo-tree")
if not ok then
	return
end

neotree.setup({
	close_if_last_window = true,
	enable_git_status = true,
	enable_diagnostics = true,

	filesystem = {
		bind_to_cwd = false,
		follow_current_file = {
			enabled = true,
		},
		hijack_netrw_behavior = "open_default",

		window = {
			position = "left",
			width = 28,

			mappings = {
				["<C-t>"] = "navigate_up",
				["?"] = "show_help",
			},
		},
	},

	default_component_configs = {
		container = {
			enable_character_fade = true,
		},

		indent = {
			with_expanders = true,
			expander_collapsed = "",
			expander_expanded = "",
		},

		icon = {
			default = "",
			folder_closed = "",
			folder_open = "",
			folder_empty = "",
			folder_empty_open = "",
			folder_symlink = "",
		},

		modified = {
			symbol = "",
		},

		git_status = {
			symbols = {
				added = "U",
				modified = "",
				deleted = "",
				renamed = "➜",
				untracked = "U",
				ignored = "◌",
				unstaged = "",
				staged = "S",
				conflict = "",
			},
		},

		diagnostics = {
			symbols = {
				hint = "",
				info = "",
				warn = "",
				error = "",
			},
		},
	},
})
