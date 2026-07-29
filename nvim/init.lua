-- Core
require("_options")
require("_keymaps")
require("_plugins")
-- 
-- Editing
require("_lsp")
require("_cmp")
require("_autopairs")
--
-- -- Navigation
require("_telescope")
require("_nvim_tree")
--
-- -- Aesthetics
require("_alpha")
require("_lualine")
require("_gitsigns")
require("_indentline")
require("_treesitter")
require("_gruvbox")

vim.filetype.add({
  extension = {
    tpp = "cpp"
  },
})

