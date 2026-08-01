local function gh(repo)
	return "https://github.com/" .. repo
end

vim.pack.add({
	-- Core
	{ src = gh("nvim-lua/plenary.nvim") },
	{ src = gh("nvim-mini/mini.nvim") },

	-- Navigation
	{ src = gh("kyazdani42/nvim-tree.lua") },

	{ src = gh("nvim-telescope/telescope.nvim") },
	{ src = gh("nvim-telescope/telescope-ui-select.nvim") },

	-- Aesthetics
	{ src = gh("lukas-reineke/indent-blankline.nvim") },
	{ src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
	{ src = gh("nvim-lualine/lualine.nvim") },
	{ src = gh("ellisonleao/gruvbox.nvim") },
	{ src = gh("lewis6991/gitsigns.nvim") },
	{ src = gh("goolord/alpha-nvim") },
	{ src = gh("folke/todo-comments.nvim") },
	{ src = gh("j-hui/fidget.nvim") },

	-- Completion
	{ src = gh("saghen/blink.cmp") },
	{ src = gh("saghen/blink.lib") },
	{ src = gh("rafamadriz/friendly-snippets") },
	{ src = gh("L3MON4D3/LuaSnip") },
	{ src = gh("windwp/nvim-autopairs") },

	-- LSP
	{ src = gh("neovim/nvim-lspconfig") },
	{ src = gh("mason-org/mason.nvim") },
	{ src = gh("mason-org/mason-lspconfig.nvim") },
	{ src = gh("WhoIsSethDaniel/mason-tool-installer.nvim") },
	{ src = gh("stevearc/conform.nvim") },
	{ src = gh("b0o/SchemaStore.nvim") },
})
