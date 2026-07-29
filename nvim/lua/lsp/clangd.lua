local function lsp_highlight_document(client)
    if client.server_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
            augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]],
            false
        )
    end
end

local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev({ border = "rounded" }) end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next({ border = "rounded" }) end, opts)
    vim.keymap.set("n", "<M-o>", "<cmd>LspClangdSwitchSourceHeader<cr>", opts)

    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

    vim.keymap.set(
        "n",
        "<leader>td",
        "<cmd>lua require 'telescope.builtin'.diagnostics()<cr>",
        opts
    )
    vim.keymap.set(
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
-- local capabilities = cmp_nvim_lsp.default_capabilities(client_capabilities)
-- capabilities.textDocument.completion.editsNearCursor = true
-- table.remove(capabilities, capabilities.offsetEncoding)

---@brief
---
--- https://clangd.llvm.org/installation.html
---
--- - **NOTE:** Clang >= 11 is recommended! See [#23](https://github.com/neovim/nvim-lspconfig/issues/23).
--- - If `compile_commands.json` lives in a build directory, you should
---   symlink it to the root of your source tree.
---   ```
---   ln -s /path/to/myproject/build/compile_commands.json /path/to/myproject/
---   ```
--- - clangd relies on a [JSON compilation database](https://clang.llvm.org/docs/JSONCompilationDatabase.html)
---   specified as compile_commands.json, see https://clangd.llvm.org/installation#compile_commandsjson

-- https://clangd.llvm.org/extensions.html#switch-between-sourceheader
local function switch_source_header(bufnr)
    local method_name = 'textDocument/switchSourceHeader'
    local client = vim.lsp.get_clients({ bufnr = bufnr, name = 'clangd' })[1]
    if not client then
        return vim.notify(('method %s is not supported by any servers active on the current buffer'):format(method_name))
    end
    local params = vim.lsp.util.make_text_document_params(bufnr)
    client.request(method_name, params, function(err, result)
        if err then
            error(tostring(err))
        end
        if not result then
            vim.notify('corresponding file cannot be determined')
            return
        end
        vim.cmd.edit(vim.uri_to_fname(result))
    end, bufnr)
end

-- local function symbol_info()
--     local bufnr = vim.api.nvim_get_current_buf()
--     local clangd_client = vim.lsp.get_clients({ bufnr = bufnr, name = 'clangd' })[1]
--     if not clangd_client or not clangd_client.supports_method 'textDocument/symbolInfo' then
--         return vim.notify('Clangd client not found', vim.log.levels.ERROR)
--     end
--     local win = vim.api.nvim_get_current_win()
--     local params = vim.lsp.util.make_position_params(win, clangd_client.offset_encoding)
--     clangd_client.request('textDocument/symbolInfo', params, function(err, res)
--         if err or #res == 0 then
--             -- Clangd always returns an error, there is not reason to parse it
--             return
--         end
--         local container = string.format('container: %s', res[1].containerName) ---@type string
--         local name = string.format('name: %s', res[1].name) ---@type string
--         vim.lsp.util.open_floating_preview({ name, container }, '', {
--             height = 2,
--             width = math.max(string.len(name), string.len(container)),
--             focusable = false,
--             focus = false,
--             border = 'single',
--             title = 'Symbol Info',
--         })
--     end, bufnr)
-- end
return {
    cmd = { "clangd", },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto', },
    root_markers = {
        '.clangd',
        '.clang-tidy',
        '.clang-format',
        'compile_commands.json',
        'compile_flags.txt',
        'configure.ac', -- AutoTools
        '.git',
    },
    capabilities = client_capabilities,
    on_attach = function(client, bufnr)
        vim.notify("ON ATTACH")
        lsp_keymaps(bufnr)
        lsp_highlight_document(client)

            local augroup = vim.api.nvim_create_augroup('LspFormatting', { clear = true })
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end,
            })

        vim.api.nvim_buf_create_user_command(0, 'LspClangdSwitchSourceHeader', function()
            switch_source_header(0)
        end, { desc = 'Switch between source/header' })

        -- vim.api.nvim_buf_create_user_command(0, 'LspClangdShowSymbolInfo', function()
        --     symbol_info()
        -- end, { desc = 'Show symbol info' })
    end,
}
