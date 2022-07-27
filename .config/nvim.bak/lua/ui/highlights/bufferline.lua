-- List of available palette_colors
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
local bg = palette_colors.mantle

local hlgroups = {
	-- buffers
	BufferLineBackground = { bg = bg },
	BufferLineBuffer = { fg = palette_colors.surface0, bg = bg },
	BufferLineBackcrust = { fg = palette_colors.surface0, bg = bg },
	BufferLineBufferVisible = { fg = palette_colors.text, bg = bg },
	BufferLineBufferSelected = { fg = palette_colors.pink, bg = bg, bold = true, italic = true },

	-- tab
	BufferLineTab = { bg = bg, fg = palette_colors.text },
	BufferLineTabSelected = { fg = palette_colors.red, bg = palette_colors.crust, bold = true },

	-- Separators
	BufferLineSeparator = { bg = bg },
	BufferLineSeparatorVisible = { bg = bg },
	BufferLineSeparatorSelected = { bg = bg },
	-- Indicators
	BufferLineIndicatorSelected = { fg = palette_colors.peach, bg = bg },
	BufferLineIndicatorVisible = { fg = palette_colors.peach, bg = bg },

	-- Modified
	BufferLineModified = { bg = bg, fg = palette_colors.green },
	BufferLineModifiedVisible = { bg = bg, fg = palette_colors.green },
	BufferLineModifiedSelected = { bg = bg, fg = palette_colors.green },

	-- Name resolver
	BufferLineDuplicate = { fg = palette_colors.rosewater, bg = bg, italic = false },
	BufferLineDuplicateVisible = { fg = palette_colors.sky, bg = bg },
	BufferLineDuplicateSelected = { fg = palette_colors.peach, bg = bg },
	-- fill
	BufferLineFill = { bg = bg },
}

return hlgroups
