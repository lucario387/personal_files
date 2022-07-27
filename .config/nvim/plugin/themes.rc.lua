-- main branch
-- local present, base46 = pcall(require, "base46")
--
-- if present then
--   base46.load_theme()
--   base46.load_highlight("treesitter")
-- end

-- dev branch
pcall(function()
  loadfile(vim.g.base46_cache .. "bg", "b")()
  loadfile(vim.g.base46_cache .. "defaults", "b")()
  loadfile(vim.g.base46_cache .. "lsp", "b")()
  loadfile(vim.g.base46_cache .. "syntax", "b")()
  loadfile(vim.g.base46_cache .. "treesitter", "b")()
end)

