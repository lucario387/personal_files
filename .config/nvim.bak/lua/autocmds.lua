local api = vim.api
local autocmd = api.nvim_create_autocmd

-- Unlist dap-repl so that it doesn't show on bufferline
autocmd("FileType", {
	pattern = { "dap-repl", "man", "qf" },
	callback = function()
		vim.bo.buflisted = false
	end,
})
local augroup = api.nvim_create_augroup("AutoCompileCatppuccin", {clear = true})

autocmd("User", {
	group = augroup,
	pattern = "PackerCompileDone",
	callback = function()
		reload_theme_auto()
		reload_compiled_hls()
	end
})

autocmd("BufWritePost", {
	group = augroup,
	pattern = {
		vim.fn.stdpath("config") .. "/lua/ui/catppuccin.lua",
		vim.fn.stdpath("config") .. "/lua/ui/highlights/*",
	},
	callback = function()
		reload_theme_auto()
		--reload_compiled_hls()
	end
})


-- for _, func in pairs(require("lazy_load")) do
-- 	func()
-- end
