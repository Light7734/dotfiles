local config = {
    virtual_text = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
        }
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = "normal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
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
