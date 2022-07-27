local colors = require("catppuccin.palettes").get_palette()
-- local latte = require("catppuccin.palettes.latte")
-- local ucolors = require("catppuccin.utils.colors")

local hlgroups = {
  BufferLineBufferVisible = { fg = colors.text },
  BufferLineBufferSelected = { fg = colors.text, bold = true, italic = true },
}

return hlgroups
