vim.g.base46_cache = vim.fn.stdpath("cache") .. "/nvchad/base46/"
require("options")

require("commands")

-- require("bootstrap")
pcall(function()
  loadfile(vim.g.base46_cache .. "bg")()
  loadfile(vim.g.base46_cache .. "defaults")()
  loadfile(vim.g.base46_cache .. "lsp")()
  loadfile(vim.g.base46_cache .. "syntax")()
  loadfile(vim.g.base46_cache .. "treesitter")()
end)

require("config.ui")
require("mappings").general()

