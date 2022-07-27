local excluded_filetypes = {
  "NvimTree",
  "TelescopePrompt",
  "TelescopeResults",
  "LspInfo",
  "lsp-installer",
}
if vim.tbl_contains(excluded_filetypes, vim.bo.filetype) then
  return
end

local saga = require "lspsaga"

-- change the lsp symbol kind
-- local kind = require("lspsaga.lspkind")


-- use custom config
saga.init_lsp_saga({
  border_style = "rounded",
  move_in_saga = { prev = "<C-p>", next = "<C-n>" },
  diagnostic_header = { " ", " ", " ", "ﯧ " },
  show_diagnostic_source = true,
  max_preview_lines = 20,
  symbol_in_winbar = {
    in_custom = false,
    enable = false,
    separator = "  ",
    show_file = true,
    click_support = false,
  },
})
