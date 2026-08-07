vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "menuone,noselect"
vim.opt.fileencoding = "utf-32"
vim.opt.ignorecase = true
vim.opt.pumheight = 12
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.scrolloff = 6
vim.opt.sidescrolloff = 6
vim.opt.showmode = false
vim.opt.colorcolumn = "0"
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.autoindent = true
vim.opt.showtabline = 0
vim.opt.cursorline = false
vim.opt.numberwidth = 4
vim.opt.shortmess:append("c")
vim.opt.laststatus = 3
vim.opt.fillchars = { eob = " " }
vim.cmd('let g:neovide_cursor_vfx_mode = "pixiedust"')
vim.cmd("let g:neovide_cursor_vfx_particle_density = 32.0")
vim.diagnostic.config({ virtual_text = false, virtual_lines = { current_line = false } })

-- lastplace
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			vim.api.nvim_win_set_cursor(0, mark)
		end
	end,
})
