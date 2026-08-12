local status_ok, conform = pcall(require, "conform")
if not status_ok then
	vim.notify("Failed to load plugin: conform" .. debug.traceback(), vim.log.levels.ERROR)
	return
end

conform.setup({
	notify_on_error = false,
	format_on_save = function(bufnr)
		return { timeout_ms = 1000 }
	end,
	default_format_opts = {
		lsp_format = "fallback", -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
	},
	-- You can also specify external formatters in here.
	formatters_by_ft = {
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescriptreact = { "prettierd" },
		svelte = { "prettierd" },
		css = { "prettierd" },
		html = { "prettierd" },
		json = { "prettierd" },
		yaml = { "prettierd" },
		markdown = { "prettierd" },
		graphql = { "prettierd" },
	},
})

vim.keymap.set({ "n", "v" }, "<leader>bf", function()
	require("conform").format({ async = true })
end, { desc = "[F]ormat buffer" })
