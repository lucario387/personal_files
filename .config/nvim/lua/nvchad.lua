local M = {}

---@param current string name of current theme
---@param new string name of new theme
M.change_theme = function(current, new)
end

M.reload_theme = function(theme)
  theme = theme or vim.g.nvchad_theme
  vim.g.nvchad_theme = theme
  require("base46").load_all_highlights()
  vim.api.nvim_exec_autocmds("User", { pattern = "NvChadThemeReload" })
end


M.write_data = function(old_data, new_data)
end

return M
