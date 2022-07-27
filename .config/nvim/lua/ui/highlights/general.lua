local colors = require("catppuccin.palettes").get_palette()
-- local latte = require("catppuccin.palettes.latte")
-- local ucolors = require("catppuccin.utils.colors")


local hlgroups = {
  Comment  = { fg = colors.yellow, bold = true, italic = true },
  markdownError = { link = "Normal" },
  LineNr = { fg = colors.text },
}

return hlgroups
