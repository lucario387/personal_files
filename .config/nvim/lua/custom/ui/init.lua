-- local M = {}
--
-- M.setup = function()
-- require("custom.ui.tabline").setup()
local disabled_filetypes = {
  "NvimTree",
  "mason",
  "packer",
  "qf",
  "trouble",
  "alpha",
  "help",
  "terminal",
  "lspinfo",
  "TelescopePrompt",
  "TelescopeResults"
}

local disabled_buftypes = {
  "nofile",
  "help",
  "prompt",
}
vim.t.bufs = vim.api.nvim_list_bufs()
require("custom.ui.tabline.autocmds")
vim.opt.showtabline = 2
vim.opt.tabline = "%{%v:lua.require('custom.ui.tabline').run()%}"
vim.opt.statusline = "%{%v:lua.require('custom.ui.statusline').draw()%}"
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    if vim.tbl_contains(disabled_filetypes, vim.bo.filetype)
      or vim.tbl_contains(disabled_buftypes, vim.bo.buftype) then
      return
    end
    vim.wo.winbar = "%{%v:lua.require('custom.ui.winbar').draw()%}"
  end
})
-- end
--
-- return M
