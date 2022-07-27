local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local utils = require("custom.ui.tabline.utils")

local disabled_buftypes = {
  "terminal",
  "prompt",
}

autocmd("TermOpen", {
  group = augroup("UnlistTerminal", { clear = true }),
  callback = function(args)
    vim.api.nvim_buf_set_option(args.buf, "buflisted", false)
  end
})

autocmd({ "BufAdd", "BufEnter" }, {
  group = augroup("BufListAdd", { clear = true }),
  callback = function(args)
    local tabnr = vim.api.nvim_get_current_tabpage()
    if vim.t[tabnr].bufs == nil then
      vim.t[tabnr].bufs = { args.buf }
      return
    end

    local buflist = vim.t[tabnr].bufs


    -- check for duplicates
    if not vim.tbl_contains(buflist, args.buf)
      and utils.buf_is_valid(args.buf) then
        -- and (args.event == "BufAdd" or utils.buf_is_valid(args.buf)) then
      table.insert(buflist, args.buf)
      vim.t[tabnr].bufs = buflist
    end
  end
})

autocmd({ "BufDelete" }, {
  callback = function(args)
    utils.delete_buffer(args.buf)
  end
})

-- autocmd({ "BufNewFile", "BufRead", "TabEnter" }, {
--   group = augroup("TabLineLazyLoad", { clear = true }),
--   callback = function()
--     if #vim.fn.getbufinfo({ buflisted = true }) > 1 or #vim.api.nvim_list_tabpages() > 1 then
--       vim.opt.showtabline = 2
--       vim.opt.tabline = "%{%v:lua.require('custom.ui').tabline()%}"
--       vim.api.nvim_del_augroup_by_name("TabLineLazyLoad")
--     end
--   end
-- })


-------------Buffer list and unlist on tab change

autocmd({ "TabNewEntered" }, {
  group = augroup("TabLineBufferList", { clear = true }),
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_option(bufnr, "buflisted", true)
    utils.add_buffer(bufnr)
  end
})
autocmd("TabEnter", {
  group = augroup("TabLineBufferList", { clear = true }),
  callback = function()
    if packer_plugins["nvim-tree.lua"] and packer_plugins["nvim-tree.lua"].loaded then
      vim.api.nvim_command("silent! NvimTreeClose")
    end
    -- utils.set_tab_bufs_listed(vim.api.nvim_get_current_tabpage())
  end
})
--
autocmd("TabLeave", {
  group = augroup("TabLineBufferUnList", { clear = true }),
  callback = function()
    if packer_plugins["nvim-tree.lua"] and packer_plugins["nvim-tree.lua"].loaded then
      vim.api.nvim_command("silent! NvimTreeClose")
      -- vim.api.nvim_cmd({
      --   cmd = "NvimTreeClose",
      --   mods = {
      --     silent = true,
      --   }
      -- })
    end
  end
})
