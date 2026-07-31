local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add({
    -- Core
    { src = gh 'nvim-lua/plenary.nvim' },
    { src = gh 'nvim-mini/mini.nvim' },

    -- Navigation
    { src = gh 'kyazdani42/nvim-tree.lua' },

    { src = gh 'nvim-telescope/telescope.nvim' },
    { src = gh 'nvim-telescope/telescope-ui-select.nvim' },

    -- Aesthetics
    { src = gh 'lukas-reineke/indent-blankline.nvim' },
    { src = gh 'nvim-treesitter/nvim-treesitter' },
    { src = gh 'nvim-lualine/lualine.nvim' },
    { src = gh 'ellisonleao/gruvbox.nvim' },
    { src = gh 'lewis6991/gitsigns.nvim' },
    { src = gh 'goolord/alpha-nvim' },
    { src = gh 'folke/todo-comments.nvim' },
    { src = gh 'j-hui/fidget.nvim' },

    -- Completion
    { src = gh 'hrsh7th/nvim-cmp' },
    { src = gh 'hrsh7th/cmp-nvim-lsp' },
    { src = gh 'hrsh7th/cmp-nvim-lua' },
    { src = gh 'hrsh7th/cmp-buffer' },
    { src = gh 'hrsh7th/cmp-path' },
    { src = gh 'hrsh7th/cmp-cmdline' },
    { src = gh 'saadparwaiz1/cmp_luasnip' },
    { src = gh 'windwp/nvim-autopairs' },
    { src = gh 'L3MON4D3/LuaSnip' },

    -- LSP
    { src = gh 'neovim/nvim-lspconfig' },
    { src = gh 'mason-org/mason.nvim' },
    { src = gh 'mason-org/mason-lspconfig.nvim' },
    { src = gh 'WhoIsSethDaniel/mason-tool-installer.nvim' },
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
