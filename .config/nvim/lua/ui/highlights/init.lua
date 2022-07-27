local M = {}


M.get_hlgroups = function(parts)
  parts = (type(parts) == "table") and parts or { "general" }
  local hl_groups = {}
  for _, part in pairs(parts) do
    local hl_table = require("ui.highlights." .. part)
    hl_groups = vim.tbl_deep_extend("force", hl_groups, hl_table)
  end
  return hl_groups
end

return M
