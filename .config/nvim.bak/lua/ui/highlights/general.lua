--local frappe = require("catppuccin.palettes.frappe")

local hlgroups = {
	Comment       = { fg = palette_colors.subtext1, },
	markdownError = { link = palette_colors.Normal },
	LineNr        = { fg = palette_colors.text },
	CmpBorder     = { fg = palette_colors.yellow, bg = palette_colors.surface0 },
	Folded        = { fg = palette_colors.sky, },
}

return hlgroups
