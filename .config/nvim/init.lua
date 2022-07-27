local present, impatient = pcall(require, "impatient")
if present then
  impatient.enable_profile()
end

local fn = vim.fn

require("options")
require("autocmds")
vim.schedule(function()
  require("mappings").setup()
  require("commands")
end)
_G.lazy = function(plugin, timer)
  if plugin then
    timer = timer or 0
    vim.defer_fn(function()
      require("packer").loader(plugin)
    end, timer)
  end
end

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  print("Cloning packer...")
  fn.system({
    "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path
  })

  vim.cmd "packadd packer.nvim"
  require("plugin")
  require("packer").sync()
end
