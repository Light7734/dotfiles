-- ~/.config/nvim/lua/lsp/servers/bash.lua
-- Full bash LSP config (with keymaps, highlights, and shfmt formatter)

-- Highlighting function
local function lsp_highlight_document(client)
    if client.server_capabilities.documentHighlightProvider then
        local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })

        vim.api.nvim_create_autocmd("CursorHold", {
            group = group,
            buffer = 0,
            callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd("CursorMoved", {
            group = group,
            buffer = 0,
            callback = vim.lsp.buf.clear_references,
        })
    end
end

-- LSP keymaps (includes shfmt shortcut)
local function lsp_keymaps(bufnr)
    local opts = { remap = true, silent = true, buffer = bufnr }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev({ border = "rounded" }) end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next({ border = "rounded" }) end, opts)
    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

    -- Telescope integration if installed
    pcall(function()
        vim.keymap.set("n", "<leader>td", "<cmd>Telescope diagnostics<cr>", opts)
        vim.keymap.set("n", "<leader>tr", "<cmd>Telescope lsp_references<cr>", opts)
    end)
end

-- Capabilities (with cmp-nvim-lsp if available)
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

-- Return the full bash-language-server config
return {
    cmd = { "bash-language-server", "start" },
    filetypes = { "bash", "sh" },
    root_markers = {
        '.git',
        '.clangd',
        '.clang-tidy',
        '.clang-format',
        'compile_commands.json',
        'compile_flags.txt',
        'configure.ac', -- AutoTools
    },
    single_file_support = true,
    settings = {
        bashIde = {
            globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
        },
    },
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
                vim.cmd([[silent! !shfmt -w -i 4 -ci %]])
            end,
        })
    end,
    capabilities = capabilities,
}
