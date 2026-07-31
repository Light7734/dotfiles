local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Set leader to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

-- Old config...

ZenActive = true

local function toggle_zen()
    if not ZenActive then
        ZenActive = true

        vim.cmd("set nonumber")
        vim.cmd("set norelativenumber")
        vim.lsp.inlay_hint.enable(false)
    else
        ZenActive = false

        vim.cmd("set relativenumber")
        vim.cmd("set number")
        vim.lsp.inlay_hint.enable(true)
    end
end

vim.api.nvim_create_user_command("ToggleZen", toggle_zen, {})

keymap("n", "<C-q>", "<cmd>ToggleZen<cr>", opts)
keymap("n", "<leader>h", "<cmd>nohl<cr>", opts)

local function format_with_prettier()
    vim.fn.system('pnpm exec prettier --write ' .. vim.fn.expand('%:p'))
    vim.cmd('edit') -- Reload the buffer after formatting
end
vim.api.nvim_create_user_command("FormatWithPrettier", format_with_prettier, {})
keymap("n", "<leader>pr", "<cmd>write<cr><cmd>FormatWithPrettier<cr>", opts)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",


vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-c>', '<CMD>%bd|e#|bd#<CR>', { desc = 'Nuke all buffer except the current one' })

vim.keymap.set('n', '<C-Up>', ':resize +2<CR>', { desc = 'Increase height of the current window' })
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>', { desc = 'Decrease height of the current window' })
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { desc = 'Increase height of the current window' })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { desc = 'Decreaseh eight of the current window' })

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function() vim.hl.on_yank() end,
})

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "p", '"_dP', opts)

-- Move text up and down
keymap("x", "<C-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<C-k>", ":move '<-2<CR>gv-gv", opts)

vim.api.nvim_set_keymap("n", "<leader>w", "<cmd>lua vim.lsp.buf.format({async = false})<cr><cmd>w!<cr>", opts)
keymap("n", "<leader>c", "<cmd>bdelete<cr>", opts)
