vim.g.catppuccin_flavour = "frappe"
local colors = require("catppuccin.palettes").get_palette()


-- local hl_groups = require("ui.highlights").get_hlgroups({ "general", "bufferline", "feline" })
require("catppuccin").setup({
  transparent_background = true,
  term_colors = true,
  compile = {
    enabled = true,
    path = vim.fn.stdpath("cache") .. "/catppuccin",
    suffix = "_compiled",
  },
  styles = {
    -- comments = { "bold", "italic" },
    conditionals = { "bold", "italic" },
    loops = { "bold", "italic" },
    operators = { "bold" },
  },
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
      lsp_trouble = true,
      cmp = true,
      lsp_saga = true,
      gitsigns = true,
      telescope = true,
      nvimtree = {
        enabled = true,
        show_root = true,
        transparent_panel = false,
      },
      indent_blankline = {
        enabled = true,
        colored_indent_levels = false,
      },
      bufferline = true,
      markdown = true,
    }
  },

  -- Custom hlgroup
  custom_highlights = {
    Comment = { fg = colors.yellow, bold = true, italic = true, },
    markdownError = { link = "Normal" },
    LineNr = { fg = colors.text, },
    BufferLineBufferVisible = { italic = true, },
    BufferLineBufferSelected = { bold = true, italic = true },
  }
})
vim.cmd "colorscheme catppuccin"
