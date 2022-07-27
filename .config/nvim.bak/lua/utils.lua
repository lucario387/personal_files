_G.setkeymaps = function(mappings)
	for mode, maps in pairs(mappings) do
		for lhs, value in pairs(maps) do
			vim.keymap.set(mode, lhs, value.callback, value.opts)
		end
	end
end

_G.lazy = function(plugin, timer)
	vim.defer_fn(function()
		-- pcall(require, "impatient")
		require("packer").loader(plugin)
	end, timer or 0)
end

_G.reload_compiled_hls = function()
	local compiled_dir = vim.fn.stdpath("cache") .. "/catppuccin/"
	local compiled_path = compiled_dir .. vim.g.catppuccin_flavour .. "_compiled.lua"
	local f = io.open(compiled_path, "r")
	if f ~= nil then
		io.close(f)
		require("plenary.reload").reload_module(compiled_dir)
		vim.cmd("luafile " .. compiled_path)
	end
	vim.cmd("colorscheme catppuccin")
end

_G.reload_theme_auto = function()
	require("plenary.reload").reload_module("ui.highlight")
	require("plenary.reload").reload_module("ui.catppuccin")
	require("ui.catppuccin")
	vim.cmd [[silent! CatppuccinCompile]]
	vim.defer_fn(function() reload_compiled_hls()end, 0)
end

_G.palette_colors = {}

local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	print("cloning packer...")
	fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd.packadd("packer.nvim")
	require("config")
	require("packer").sync()
end
