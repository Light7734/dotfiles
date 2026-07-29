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
--- https://github.com/sveltejs/language-tools/tree/master/packages/language-server
---
--- Note: assuming that [ts_ls](#ts_ls) is setup, full JavaScript/TypeScript support (find references, rename, etc of symbols in Svelte files when working in JS/TS files) requires per-project installation and configuration of [typescript-svelte-plugin](https://github.com/sveltejs/language-tools/tree/master/packages/typescript-plugin#usage).
---
--- `svelte-language-server` can be installed via `npm`:
--- ```sh
--- npm install -g svelte-language-server
--- ```

return {
    cmd = { 'svelteserver', '--stdio' },
    filetypes = { 'svelte' },
    root_markers = { 'package.json', '.git' },
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        lsp_keymaps(bufnr)
        lsp_highlight_document(client)

        vim.api.nvim_buf_create_user_command(bufnr, 'LspMigrateToSvelte5', function()
            client:exec_cmd({
                command = 'migrate_to_svelte_5',
                arguments = { vim.uri_from_bufnr(bufnr) },
            })
        end, { desc = 'Migrate Component to Svelte 5 Syntax' })
    end,
}
