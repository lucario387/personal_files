local M = {}

local api = vim.api
local autocmd = api.nvim_create_autocmd

M.bufferline = function()
	--Only load bufferline when there's more than 2 listed buffers
	autocmd({ "BufNewFile", "BufRead", "TabEnter" }, {
		group = api.nvim_create_augroup("BufferLineLazyLoad", {}),
		callback = function()
			if #vim.fn.getbufinfo({ buflisted = 1 }) >= 2 then
				lazy("bufferline.nvim")
				vim.defer_fn(function() vim.cmd("colorscheme catppuccin") end, 0)
				api.nvim_del_augroup_by_name("BufferLineLazyLoad")
			end
		end,
	})
end

M.statusline = function()
	-- Lazy load feline
	autocmd("VimEnter", {
		once = true,
		callback = function()
			lazy("feline.nvim")
		end
	})
end

M.blankline = function()
	autocmd({ "BufReadPre", "BufNewFile" }, {
		once = true,
		callback = function()
			lazy("indent-blankline.nvim")
		end,
	})
end

M.matchup = function()
	autocmd({ "BufReadPre", "BufNewFile" }, {
		once = true,
		callback = function()
			lazy("vim-matchup")
		end,
	})
end
-- M.mason = function()
-- 	autocmd({ "VimEnter" }, {
-- 		once = true,
-- 		callback = function()
-- 			lazy("mason.nvim")
-- 		end
-- 	})
-- end

M.colorizer = function()
	autocmd("BufReadPre", {
		once = true,
		callback = function()
			lazy("nvim-colorizer.lua")
		end,
	})
end

M.lsp = function()
	autocmd("UIEnter", {
		once = true,
		callback = function()
			lazy("nvim-lspconfig")
		end,
	})
end

M.gitsigns = function()
	autocmd("BufRead", {
		group = api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
		callback = function()
			if package.loaded["gitsigns"] then
				api.nvim_del_augroup_by_name("GitSignsLazyLoad")
			end
			if vim.api.nvim_buf_get_lines(0, 0, -1, false) ~= { "" } then
				vim.loop.spawn("git", {
					args = {
						"rev-parse",
						vim.fn.expand("%:p:h")
					},
				},
					function(code, _)
						if code == 0 then
							vim.schedule(function() require("packer").loader("gitsigns.nvim") end)
						end
					end
				)
			end
		end,
	})
end

-- load nvim-dap if current directory exists a .vscode/launch.json file
-- As it may contains debug configurations for such project
M.dap = function()
	autocmd({ "VimEnter", "DirChanged" }, {
		group = api.nvim_create_augroup("DAPLazyLoad", {}),
		callback = function()
			if vim.loop.fs_stat(vim.fn.getcwd() .. "/.vscode/launch.json") then
				-- api.nvim_del_augroup_by_name("DAPLazyLoad")
				require("config.dap").load_vscode_config()
			end
		end,
	})
end

return M
