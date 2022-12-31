local M = {}

M.draw = function()
  if vim.tbl_contains({
  "nofile",
  "help",
  "prompt",
  }, vim.bo.buftype)
    or vim.v.wrap
  then
    return ""
  end
  local line = vim.fn.line(".")
  return (vim.v.lnum == line or not vim.v.relnum) and "%=%#Comment#%l%s" or "%=%r%s"
  -- return vim.v.lnum < x and 
  --   "%=%{v:relnum?-v:relnum:v:lnum}%s%C" or 
  -- return "%=%{v:relnum?v:relnum:v:lnum}%s%C"
end

return M
