vim.diagnostic.config {
    update_in_insert = false,
    severity_sort = true,
    underline = { severity = { min = vim.diagnostic.severity.WARN } },

    -- Can switch between these as you prefer
    virtual_text = true, -- Text shows up at the end of the line
    virtual_lines = false, -- Text shows up underneath the line, with virtual lines

    -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
    jump = {
        on_jump = function(_, bufnr)
            vim.diagnostic.open_float {
                bufnr = bufnr,
                scope = 'cursor',
                focus = false,
            }
        end,
    },

    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
        }
    },

    float = {
        focusable = false,
        style = "normal",
        border = "rounded",
        source = "if_many",
        header = "",
        prefix = "",
    },
}

local config = {
    update_in_insert = true,
    underline = true,
    severity_sort = true,
}

vim.filetype.add({
    extension = {
        svx = "markdown",
    }
})

vim.diagnostic.config(config)

vim.lsp.config("clangd", require("lsp/clangd"))
vim.lsp.config("luals", require("lsp/lua_ls"))
vim.lsp.config("mdx_analyzer", require("lsp/mdx_analyzer"))
vim.lsp.config("pyright", require("lsp/pyright"))
vim.lsp.config("svelte", require("lsp/svelte"))
vim.lsp.config("tailwindcss", require("lsp/tailwindcss"))
vim.lsp.config("ts_ls", require("lsp/ts_ls"))
vim.lsp.config("cmake", require("lsp/cmake"))
vim.lsp.config("bash", require("lsp/bash"))
vim.lsp.buf.hover({ border = "rounded" })
vim.lsp.buf.signature_help({ border = "rounded" })
vim.lsp.enable({
    'cmake',

    'bash',

    'clangd',
    'luals',

    'svelte',
    'tailwindcss',
    "ts_ls",
    "mdx_analyzer",

    "pyright",
})
