local configs = require("nvim-treesitter")

configs.setup({
	ensure_installed = "all",
	sync_install = false,
	ignore_install = { "" },
	autopairs = {
		enable = true,
	},
	context_commenting = {
		enable = true,
		enable_autocmd = false,
	},
	highlight = {
		enable = true,
		disable = { "" },
		additional_vim_regex_highlighting = true,
	},
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    -- C/C++
    'c',
    'cpp',
    'cuda',
    'hpp',
    'cppm',

    -- Lua
    'lua',
    'luadoc',

    -- CMake
    'cmake',

    -- Shell
    'sh',
    'bash',
    'zsh',
    'fish',

    -- Git
    'gitcommit',
    'gitrebase',
    'gitignore',
    'gitattributes',
    'gitconfig',

    -- YAML
    'yaml',

    -- JSON
    'json',
    'jsonc',

    -- TOML
    'toml',

    -- Config files
    'ini',
    'dosini',

    -- Markdown
    'markdown',
    'markdown_inline',

    -- Misc
    'regex',
    'query', -- treesitter queries

    'svelte',
    'typescript',
  },
  callback = function()
    vim.treesitter.start()
  end,
})
