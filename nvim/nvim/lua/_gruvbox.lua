require("gruvbox").setup({
    overrides = {
        SignColumn = { bg = "#282828" }
    },
    transparent_mode = true,
})
vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])
