require("gruvbox").setup({
	overrides = {
		SignColumn = { bg = "#282828" },
	},
	transparent_mode = true,
})

vim.o.background = "dark"

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { link = "GruvboxBlue" })
	end,
})

vim.cmd([[colorscheme gruvbox]])
