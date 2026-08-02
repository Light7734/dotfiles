local status_ok, mini_icons = pcall(require, "mini.icons")
if not status_ok then
	return
end

mini_icons.setup()
MiniIcons.mock_nvim_web_devicons()

vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "DiagnosticError" })

require("mini.indentscope").setup({
	symbol = "▏", -- The exact thin character you requested
	options = {
		try_as_border = true,
		-- Set to false if you want it to jump outwards on empty lines
		indent_at_cursor = true,
	},
	draw = {
		delay = 0,
		-- Disable animations and top/bottom underlines
		animation = require("mini.indentscope").gen_animation.none(),
	},
})
