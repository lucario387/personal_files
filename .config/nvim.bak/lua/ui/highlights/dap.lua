-- List of available colors
-- base
-- blue
-- crust
-- flamingo
-- green
-- lavender
-- mantle
-- maroon
-- mauve
-- overlay0
-- overlay1
-- overlay2
-- peach
-- pink
-- red
-- rosewater
-- sapphire
-- sky
-- subtext0
-- subtext1
-- surface0
-- surface1
-- surface2
-- teal
-- text
-- yellow

return {
	NvimDapVirtualText = { fg = palette_colors.yellow, link = nil, bold = false, italic = false },
	NvimDapVirtualTextError = { link = palette_colors.DiagnosticError },
	NvimDapVirtualTextChanged = { fg = palette_colors.sky, link = nil, bold = true, italic = true },
}
