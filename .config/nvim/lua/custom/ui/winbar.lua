local M = {}

local fn = vim.fn
local api = vim.api


M.file_name = function()
  local filename, extension = fn.expand("%:t"), fn.expand("%:e")
  local icon, icon_hl = require("nvim-web-devicons").get_icon(filename, extension, { default = true })
  return "%#" .. icon_hl .. "#" .. icon .. " %#WinBar#" .. fn.expand("%:.")
end

M.lsp_diagnostics = function()
  if #vim.lsp.get_active_clients({ bufnr = 0 }) == 0 then return "" end
  local num_errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local num_warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  local num_hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
  local num_infos = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  return string.format(
    "%%#StLSPErrors# %d %%#StLSPWarnings# %d %%#StLSPHints# %d %%#StLSPInfo# %d ",
    num_errors, num_warnings, num_hints, num_infos)
end

M.modified = function()
  if api.nvim_buf_get_option(0, "modified") then
    return "%#TabLineModified# "
  end
  return ""
end

M.draw = function()
  return table.concat({
    M.modified(),
    M.file_name(),

    "%=",
    -- M.lsp_diagnostics(),
  })
end

return M
