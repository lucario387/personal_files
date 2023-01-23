vim.api.nvim_create_user_command("ThemeCompile", function()
  require("base46").load_all_highlights()
end, {})

vim.api.nvim_create_autocmd("VimEnter", {
  -- once = true,
  callback = function()
    vim.cmd("clearjumps")
  end,
})
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.cmd("startinsert")
  end,
  pattern = "term://*",
})

vim.api.nvim_create_autocmd({ "BufLeave" }, {
  callback = function()
    vim.cmd("stopinsert")
  end,
  pattern = "term://*",
})
