local M = {}


M.get_hlgroups = function(parts)
	parts = parts and parts or { "general", "dap", "bufferline", "feline" }
	local hl_groups = {}
	for _, part in pairs(parts) do
		local hl_table = require("ui.highlights." .. part)
		hl_groups = vim.tbl_deep_extend("force", hl_groups, hl_table)
	end
	-- Use colorgroups from catppuccin color table and convert it to respective string
	-- for hl_name, opts in pairs(hl_groups) do
	-- 	opts.fg = colors[opts.fg]
	-- 	opts.bg = colors[opts.bg]
	-- 	--print(hl_name, vim.inspect(hl_groups[hl_name]))
	-- end
	return hl_groups
end

return M
