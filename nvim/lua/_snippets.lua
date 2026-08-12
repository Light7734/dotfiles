local status_ok_luasnip, luasnip = pcall(require, "luasnip")
if not status_ok_luasnip then
    vim.notify("Failed to load module: luasnip " .. debug.traceback(), vim.log.levels.ERROR)
    return
end

local status_ok_loaders, luasnip_loaders_fromvscode = pcall(require, "luasnip.loaders.from_vscode")
if not status_ok_loaders then
    vim.notify("Failed to load module: luasnip.loaders.from_vscode" .. debug.traceback(), vim.logl.levels.ERROR)
    return
end

luasnip.setup({})
luasnip_loaders_fromvscode.lazy_load()
