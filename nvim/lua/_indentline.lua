-- We need to do this stupid approach of having 2 plugins becausd stupid ibl v3 no longer simply
-- highlights the outer-most indentation line and uses somes stupid treesitter logic to F everything
-- up But mini.indentscope works properly yet doesn't provide the other inactive indentline lines,
-- hence we use both.

local status_ok, hlchunk = pcall(require, "hlchunk")
if not status_ok then
	return
end

hlchunk.setup({
	indent = {
		enable = true,
		chars = {
			" ",
			"▏",
			"▏",
			"▏",
			"▏",
			"too many scopes :(",
		},
		-- ...
	},
})
