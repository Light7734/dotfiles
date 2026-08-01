local status_ok, blink = pcall(require, "blink.cmp")
if not status_ok then
	print("Failed to load module: blink")
	return
end

blink.setup({
	keymap = {
		preset = "none",

		-- Selection
		["<C-j>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },

		-- Documentation
		["<C-f>"] = { "scroll_documentation_down", "fallback" },
		["<C-b>"] = { "scroll_documentation_up", "fallback" },

		-- Show completion menu
		["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },

		-- Close completion menu
		["<C-e>"] = { "hide", "fallback" },

		-- Disable <C-y>
		["<C-y>"] = {},

		-- Confirm selection (like select = false)
		["<CR>"] = { "accept", "fallback" },

		-- Tab navigation
		["<Tab>"] = {
			"select_next",
			"snippet_forward",
			"fallback",
		},

		["<S-Tab>"] = {
			"select_prev",
			"snippet_backward",
			"fallback",
		},
	},

	appearance = {
		-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
		-- Adjusts spacing to ensure icons are aligned
		nerd_font_variant = "mono",
	},

	completion = {
		-- By default, you may press `<c-space>` to show the documentation.
		-- Optionally, set `auto_show = true` to show the documentation after a delay.
		documentation = { auto_show = true, auto_show_delay_ms = 0 },
	},

	sources = {
		default = { "lsp", "path", "snippets" },
	},

	snippets = { preset = "luasnip" },

	-- Blink.cmp includes an optional, recommended rust fuzzy matcher,
	-- which automatically downloads a prebuilt binary when enabled.
	--
	-- By default, we use the Lua implementation instead, but you may enable
	-- the rust implementation via `'prefer_rust_with_warning'`
	--
	-- See `:help blink-cmp-config-fuzzy` for more information
	fuzzy = { implementation = "lua" },

	-- Shows a signature help window while you type arguments for a function
	signature = { enabled = true },
})
