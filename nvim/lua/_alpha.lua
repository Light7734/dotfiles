local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {}
dashboard.section.buttons.val = {}
dashboard.section.footer.val = "An idiot admires complexity, a genius admires simplicity. -- Terry A. Davis"
dashboard.opts.opts.noautocmd = true

alpha.setup(dashboard.opts)
