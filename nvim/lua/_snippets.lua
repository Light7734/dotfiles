local status_ok_luasnip, luasnip = pcall(require, "luasnip")
if not status_ok_luasnip then
	print("Failed to load module: luasnip")
	return
end

local status_ok_loaders, luasnip_loaders_fromvscode = pcall(require, "luasnip.loaders.fromvscode")
if not status_ok_loaders then
	print("Failed to load module: luasnip.loaders.fromvscode")
	return
end

luasnip.setup({})
luasnip_loaders_fromvscode.lazy_load()
