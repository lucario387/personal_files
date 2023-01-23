local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

if not vim.loop.fs_stat(install_path) then
  vim.fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })

  vim.fn.mkdir(vim.g.base46_cache, "p")
  vim.cmd("packadd packer.nvim")
  require("plugins")
  require("packer").sync()
end
