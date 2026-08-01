local status_ok, conform = pcall(require, "conform")
if not status_ok then
	print("Failed to load plugin: conform")
	return
end

conform.setup({
	notify_on_error = false,
	format_on_save = function(bufnr)
		-- You can specify filetypes to autoformat on save here:
		local enabled_filetypes = {
			lua = true,
			python = true,
			cpp = true,
			cmake = true,
			svelte = true,
			markdown = true,
			svx = true,
			toml = true,
			yaml = true,
		}
		if enabled_filetypes[vim.bo[bufnr].filetype] then
			return { timeout_ms = 500 }
		else
			return nil
		end
	end,
	default_format_opts = {
		lsp_format = "fallback", -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
	},
	-- You can also specify external formatters in here.
	formatters_by_ft = {
		-- rust = { 'rustfmt' },
		-- Conform can also run multiple formatters sequentially
		-- python = { "isort", "black" },
		--
		-- You can use 'stop_after_first' to run the first available formatter from the list
		-- javascript = { "prettierd", "prettier", stop_after_first = true },
	},
})

vim.keymap.set({ "n", "v" }, "<leader>bf", function()
	require("conform").format({ async = true })
end, { desc = "[F]ormat buffer" })
