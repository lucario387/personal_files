local M = {}

M.plugins = require("custom.plugins.packer")

M.mappings = require("custom.mappings")

M.ui = {
  hl_add = require("custom.ui.highlights").add,
  hl_override = require("custom.ui.highlights").override,
  theme_toggle = { "vscode_dark", "catppuccin_latte" },
  theme = "vscode_dark",
}

return M
