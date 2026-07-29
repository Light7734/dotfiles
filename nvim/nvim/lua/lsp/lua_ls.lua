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
capabilities.textDocument.completion.editsNearCursor = true

---@brief
---
--- https://github.com/luals/lua-language-server
---
--- Lua language server.
---
--- `lua-language-server` can be installed by following the instructions [here](https://luals.github.io/#neovim-install).
---
--- The default `cmd` assumes that the `lua-language-server` binary can be found in `$PATH`.
---
--- If you primarily use `lua-language-server` for Neovim, and want to provide completions,
--- analysis, and location handling for plugins on runtime path, you can use the following
--- settings.
---
--- ```lua
--- vim.lsp.config('lua_ls', {
---   on_init = function(client)
---     if client.workspace_folders then
---       local path = client.workspace_folders[1].name
---       if path ~= vim.fn.stdpath('config') and (vim.uv.fs_stat(path..'/.luarc.json') or vim.uv.fs_stat(path..'/.luarc.jsonc')) then
---         return
---       end
---     end
---
---     client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
---       runtime = {
---         -- Tell the language server which version of Lua you're using
---         -- (most likely LuaJIT in the case of Neovim)
---         version = 'LuaJIT'
---       },
---       -- Make the server aware of Neovim runtime files
---       workspace = {
---         checkThirdParty = false,
---         library = {
---           vim.env.VIMRUNTIME
---           -- Depending on the usage, you might want to add additional paths here.
---           -- "${3rd}/luv/library"
---           -- "${3rd}/busted/library",
---         }
---         -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
---         -- library = vim.api.nvim_get_runtime_file("", true)
---       }
---     })
---   end,
---   settings = {
---     Lua = {}
---   }
--- })
--- ```
---
--- See `lua-language-server`'s [documentation](https://luals.github.io/wiki/settings/) for an explanation of the above fields:
--- * [Lua.runtime.path](https://luals.github.io/wiki/settings/#runtimepath)
--- * [Lua.workspace.library](https://luals.github.io/wiki/settings/#workspacelibrary)
---
return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = {
        '.luarc.json',
        '.luarc.jsonc',
        '.luacheckrc',
        '.stylua.toml',
        'stylua.toml',
        'selene.toml',
        'selene.yml',
        '.git',
    },

    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT'
            },

            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },

            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file("", true)
            },

            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        }
    },

    capabilities = capabilities,
    on_attach = function(client, bufnr)
        lsp_keymaps(bufnr)
        lsp_highlight_document(client)

        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format()
                end,
            })
        end
    end,
}
