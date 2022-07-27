local vary_color = function(latte_clr, clr)
	if vim.g.catppuccin_flavour == "latte" then return latte_clr
	else return clr
	end
end
local bg = vary_color(palette_colors.crust, palette_colors.surface0)
local text = vary_color(palette_colors.base, palette_colors.surface0)
local hlgroups = {
	FelineInviSep = { fg = text, bg = bg },

	-- Git Branch
	FelineGitBranch  = { bg = bg, fg = palette_colors.mauve },
	FelineGitAdded   = { bg = bg, fg = palette_colors.green },
	FelineGitChanged = { bg = bg, fg = palette_colors.yellow },
	FelineGitRemoved = { bg = bg, fg = palette_colors.red },

	-- Vim Modes
	FelineNormalMode      = { fg = text, bold = true, bg = palette_colors.lavender },
	FelineOpMode          = { fg = text, bold = true, bg = palette_colors.lavender },
	FelineInsertMode      = { fg = text, bold = true, bg = palette_colors.green },
	FelineTerminalMode    = { fg = text, bold = true, bg = palette_colors.green },
	FelineVisualMode      = { fg = text, bold = true, bg = palette_colors.flamingo },
	FelineReplaceMode     = { fg = text, bold = true, bg = palette_colors.maroon },
	FelineSelectMode      = { fg = text, bold = true, bg = palette_colors.maroon },
	FelinePromptMode      = { fg = text, bold = true, bg = palette_colors.teal },
	FelineMoreMode        = { fg = text, bold = true, bg = palette_colors.teal },
	FelineCommandMode     = { fg = text, bold = true, bg = palette_colors.peach },
	FelineShellMode       = { fg = text, bold = true, bg = palette_colors.green },
	FelineNoneMode        = { fg = text, bold = true, bg = palette_colors.sky },
	-- Separators for Vim Modes
	FelineNormalModeSep   = { bg = bg, fg = palette_colors.lavender },
	FelineOpModeSep       = { bg = bg, fg = palette_colors.lavender },
	FelineInsertModeSep   = { bg = bg, fg = palette_colors.green },
	FelineTerminalModeSep = { bg = bg, fg = palette_colors.green },
	FelineVisualModeSep   = { bg = bg, fg = palette_colors.flamingo },
	FelineReplaceModeSep  = { bg = bg, fg = palette_colors.maroon },
	FelineSelectModeSep   = { bg = bg, fg = palette_colors.maroon },
	FelinePromptModeSep   = { bg = bg, fg = palette_colors.teal },
	FelineMoreModeSep     = { bg = bg, fg = palette_colors.teal },
	FelineCommandModeSep  = { bg = bg, fg = palette_colors.peach },
	FelineShellModeSep    = { bg = bg, fg = palette_colors.green },
	FelineNoneModeSep     = { bg = bg, fg = palette_colors.sky },

	-- LSP
	FelineLSPProgress = { bg = bg, fg = palette_colors.rosewater },
	FelineLSPClient   = { bg = bg, fg = palette_colors.blue, bold = true },
	FelineLSPErrors   = { bg = bg, fg = palette_colors.red },
	FelineLSPWarnings = { bg = bg, fg = palette_colors.yellow },
	FelineLSPHints    = { bg = bg, fg = palette_colors.rosewater },
	FelineLSPInfo     = { bg = bg, fg = palette_colors.sky },

	-- Miscellaneous
	FelineFileInfoSep               = { bg = bg, fg = palette_colors.sky },
	FelineFileInfoPosition          = { bg = palette_colors.sky, fg = text },
	FelineFileInfoPercentage        = { bg = palette_colors.sky, fg = text },
	FelineDirInfoDirectory          = { bg = palette_colors.sapphire, fg = text },
	FelineDirInfoDirectorySep       = { fg = palette_colors.sapphire, bg = palette_colors.teal },
	FelineDirInfoDirectorySepNoFile = { fg = palette_colors.sapphire, bg = bg },
	FelineDirInfoFilename           = { bg = palette_colors.teal, fg = text, bold = true },
	FelineDirInfoFilenameSep        = { fg = palette_colors.teal, bg = bg },
	FelineDirInfoSessionStatus      = { fg = palette_colors.sky, bg = bg }

}

return hlgroups
