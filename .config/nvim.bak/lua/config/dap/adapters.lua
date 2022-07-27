local M = {}

local fn = vim.fn
local mason_path = fn.stdpath("data") .. "/mason"

M["cppdbg"] = {
	id = "cppdbg",
	type = "executable",
	-- Must be absolute path to OpenDebugAD7
	command = mason_path .. "/bin/OpenDebugAD7",
}


return M
