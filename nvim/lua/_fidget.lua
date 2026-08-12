local status_ok, fidget = pcall(require, "fidget")
if not status_ok then
	vim.notify("Failed to require fidget" .. debug.traceback(), vim.log.levels.ERROR)
	return
end

fidget.setup({})
