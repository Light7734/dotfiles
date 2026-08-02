-- We need to do this stupid approach of having 2 plugins becausd stupid ibl v3 no longer simply
-- highlights the outer-most indentation line and uses somes stupid treesitter logic to F everything
-- up But mini.indentscope works properly yet doesn't provide the other inactive indentline lines,
-- hence we use both.

require("ibl").setup({
	indent = {
		char = "▏",
		tab_char = "▏",
	},
	scope = {
		enabled = false,
	},
	exclude = {
		filetypes = {
			"help",
			"alpha",
			"dashboard",
			"neo-tree",
			"Trouble",
			"lazy",
			"mason",
		},
	},
})

vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "DiagnosticError" })
require("mini.indentscope").setup({
	symbol = "▏",
	options = {
		try_as_border = true,
		indent_at_cursor = true,
	},
	draw = {
		delay = 0,
		-- Disable animations to make it snappy
		animation = require("mini.indentscope").gen_animation.none(),
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
	callback = function()
		vim.b.miniindentscope_disable = true
	end,
})
