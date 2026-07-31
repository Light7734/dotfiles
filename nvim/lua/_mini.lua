local status_ok, mini_icons = pcall(require, "mini.icons")
if not status_ok then
	return
end

mini_icons.setup()
MiniIcons.mock_nvim_web_devicons()
