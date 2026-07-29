vim.pack.add({
    -- Core
    { src = "https://github.com/nvim-lua/plenary.nvim" },

    -- Navigation
    { src = "https://github.com/kyazdani42/nvim-tree.lua" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/slarwise/telescope-args.nvim" },

    -- Aesthetics
    { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/kyazdani42/nvim-web-devicons" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/ellisonleao/gruvbox.nvim" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/goolord/alpha-nvim" },
    { src = "https://github.com/xiyaowong/transparent.nvim" },

    -- Completion
    { src = "https://github.com/hrsh7th/nvim-cmp" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lua" },
    { src = "https://github.com/hrsh7th/cmp-buffer" },
    { src = "https://github.com/hrsh7th/cmp-path" },
    { src = "https://github.com/hrsh7th/cmp-cmdline" },
    { src = "https://github.com/saadparwaiz1/cmp_luasnip" },
    { src = "https://github.com/windwp/nvim-autopairs" },
    { src = "https://github.com/L3MON4D3/LuaSnip" },

    -- LSP
    { src = "https://github.com/neovim/nvim-lspconfig" },
})

-- require("_plugins_bootstrap")
-- require("lazy").setup({
--     spec = {
--         -- Core
--         { 'nvim-lua/plenary.nvim' },
--
--         -- Navigation
--         { "kyazdani42/nvim-tree.lua" },
--         { 'nvim-telescope/telescope.nvim' },
--         { "slarwise/telescope-args.nvim" },
--
--         -- Aesthetics
--         { "lukas-reineke/indent-blankline.nvim" },
--         { "nvim-treesitter/nvim-treesitter", lazy = false, build = ":TSUpdate" },
--         { "kyazdani42/nvim-web-devicons" },
--         { "nvim-lualine/lualine.nvim" },
--         { "ellisonleao/gruvbox.nvim" },
--         { "lewis6991/gitsigns.nvim" },
--         { "goolord/alpha-nvim" },
--         { "xiyaowong/transparent.nvim" },
--
--         -- Auto-complete
--         { "hrsh7th/nvim-cmp" },
--         { "hrsh7th/cmp-nvim-lsp" },
--         { "hrsh7th/cmp-nvim-lua" },
--         { "hrsh7th/cmp-buffer" },
--         { "hrsh7th/cmp-path" },
--         { "hrsh7th/cmp-cmdline" },
--         { "saadparwaiz1/cmp_luasnip" },
--         { "windwp/nvim-autopairs" },
--         { "L3MON4D3/LuaSnip" },
--
--         -- Lsp
--         { "neovim/nvim-lspconfig" },
--     },
--     install = { colorscheme = { "gruvbox" } },
--     checker = { enabled = true },
-- })
