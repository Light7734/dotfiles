local function lsp_highlight_document(client)
    if client.server_capabilities.document_highlight then
        vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })

        vim.api.nvim_create_autocmd("CursorHold", {
            group = "lsp_document_highlight",
            buffer = 0,
            callback = function()
                vim.lsp.buf.document_highlight()
            end,
        })

        vim.api.nvim_create_autocmd("CursorMoved", {
            group = "lsp_document_highlight",
            buffer = 0,
            callback = function()
                vim.lsp.buf.clear_references()
            end,
        })
    end
end

local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }

    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({border="rounded"})<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({border="rounded"})<CR>', opts)

    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)

    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<leader>td",
        "<cmd>lua require 'telescope.builtin'.diagnostics()<cr>",
        opts
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<leader>tr",
        "<cmd>lua require 'telescope.builtin'.lsp_references()<CR>",
        opts
    )
end

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
    print("Failed to require cmp_nvim_lsp")
    return
end

local client_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = cmp_nvim_lsp.default_capabilities(client_capabilities)
capabilities.offsetEncoding = { "utf-8", "utf-16" }
---@brief
---
--- https://github.com/typescript-language-server/typescript-language-server
---
--- `ts_ls`, aka `typescript-language-server`, is a Language Server Protocol implementation for TypeScript wrapping `tsserver`. Note that `ts_ls` is not `tsserver`.
---
--- `typescript-language-server` depends on `typescript`. Both packages can be installed via `npm`:
--- ```sh
--- npm install -g typescript typescript-language-server
--- ```
---
--- To configure typescript language server, add a
--- [`tsconfig.json`](https://www.typescriptlang.org/docs/handbook/tsconfig-json.html) or
--- [`jsconfig.json`](https://code.visualstudio.com/docs/languages/jsconfig) to the root of your
--- project.
---
--- Here's an example that disables type checking in JavaScript files.
---
--- ```json
--- {
---   "compilerOptions": {
---     "module": "commonjs",
---     "target": "es6",
---     "checkJs": false
---   },
---   "exclude": [
---     "node_modules"
---   ]
--- }
--- ```
---
--- ### Vue support
---
--- As of 2.0.0, Volar no longer supports TypeScript itself. Instead, a plugin
--- adds Vue support to this language server.
---
--- *IMPORTANT*: It is crucial to ensure that `@vue/typescript-plugin` and `volar `are of identical versions.
---
--- ```lua
--- vim.lsp.config('ts_ls', {
---   init_options = {
---     plugins = {
---       {
---         name = "@vue/typescript-plugin",
---         location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
---         languages = {"javascript", "typescript", "vue"},
---       },
---     },
---   },
---   filetypes = {
---     "javascript",
---     "typescript",
---     "vue",
---   },
--- })
---
--- -- You must make sure volar is setup
--- -- e.g. require'lspconfig'.volar.setup{}
--- -- See volar's section for more information
--- ```
---
--- `location` MUST be defined. If the plugin is installed in `node_modules`,
--- `location` can have any value.
---
--- `languages` must include `vue` even if it is listed in `filetypes`.
---
--- `filetypes` is extended here to include Vue SFC.

return {
    init_options = { hostInfo = 'neovim' },
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
    },
    root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        lsp_keymaps(bufnr)
        lsp_highlight_document(client)
    end,
}
