--local present, impatient =
pcall(require, "impatient")

require("utils")
require("options")
require("autocmds")

vim.schedule(function()
	require("mappings")
	require("commands")
	require("ui.manage_tab")
end)
