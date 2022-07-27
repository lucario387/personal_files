-- local M = {}
--
local modules = require("custom.ui.tabline.modules")
--
-- M.setup = function()
--   vim.t.bufs = vim.api.nvim_list_bufs()
--   require("custom.ui.tabline.autocmds")
--   vim.opt.showtabline = 2
--   vim.opt.tabline = "%{%v:lua.require('custom.ui.tabline').run()%}"
-- end
--
-- M.run = function()
return {
  run = function()
    return table.concat({
      modules.padding_ft("NvimTree"),
      modules.bufferlist(),
      "%=",
      modules.tablist()
      -- "TEST"
    })
  end
}
-- end
--
-- return M
