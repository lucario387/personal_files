local colors = require("catppuccin.palettes").get_palette()
local latte = require("catppuccin.palettes.latte")
local ucolors = require("catppuccin.utils.colors")

local hlgroups = {
  FelineStatusline = { bg = colors.base },

  -- Git Branch
  FelineGitBranch  = { bg = colors.overlay0, fg = latte.pink },
  FelineGitAdded   = { bg = colors.overlay0, fg = latte.green },
  FelineGitChanged = { bg = colors.overlay0, fg = latte.yellow },
  FelineGitRemoved = { bg = colors.overlay0, fg = latte.red },

  -- Separators for Git area
  FelineGitSep = { fg = colors.overlay0, bg = colors.base },

  -- Vim Modes
  FelineNormalMode        = { fg = colors.base, bold = true, bg = latte.green },
  FelineInsertMode        = { fg = colors.base, bold = true, bg = latte.red },
  FelineVisualMode        = { fg = colors.base, bold = true, bg = latte.pink },
  FelineOpMode            = { fg = colors.base, bold = true, bg = latte.green },
  FelineBlockMode         = { fg = colors.base, bold = true, bg = latte.blue },
  FelineReplaceMode       = { fg = colors.base, bold = true, bg = latte.mauve },
  FelineVisualReplaceMode = { fg = colors.base, bold = true, bg = latte.mauve },
  FelineEnterMode         = { fg = colors.base, bold = true, bg = latte.sky },
  FelineMoreMode          = { fg = colors.base, bold = true, bg = latte.sky },
  FelineSelectMode        = { fg = colors.base, bold = true, bg = latte.yellow },
  FelineCommandMode       = { fg = colors.base, bold = true, bg = latte.green },
  FelineShellMode         = { fg = colors.base, bold = true, bg = latte.green },
  FelineTerminalMode      = { fg = colors.base, bold = true, bg = latte.green },
  FelineNoneMode          = { fg = colors.base, bold = true, bg = ucolors.blend(latte.red, latte.green, 0.5) },

  -- Separators for Vim Modes
  FelineNormalModeSep        = { bg = colors.base, fg = latte.green },
  FelineInsertModeSep        = { bg = colors.base, fg = latte.red },
  FelineVisualModeSep        = { bg = colors.base, fg = latte.pink },
  FelineOpModeSep            = { bg = colors.base, fg = latte.green },
  FelineBlockModeSep         = { bg = colors.base, fg = latte.blue },
  FelineReplaceModeSep       = { bg = colors.base, fg = latte.mauve },
  FelineVisualReplaceModeSep = { bg = colors.base, fg = latte.mauve },
  FelineEnterModeSep         = { bg = colors.base, fg = latte.sky },
  FelineMoreModeSep          = { bg = colors.base, fg = latte.sky },
  FelineSelectModeSep        = { bg = colors.base, fg = latte.yellow },
  FelineCommandModeSep       = { bg = colors.base, fg = latte.green },
  FelineShellModeSep         = { bg = colors.base, fg = latte.green },
  FelineTerminalModeSep      = { bg = colors.base, fg = latte.green },
  FelineNoneModeSep          = { bg = colors.base, fg = ucolors.blend(latte.red, latte.green, 0.5) },

  -- LSP
  FelineLSPError      = { bg = colors.overlay0, fg = latte.red },
  FelineLSPWarning    = { bg = colors.overlay0, fg = latte.yellow },
  FelineLSPHints      = { bg = colors.overlay0, fg = latte.mauve },
  FelineLSPInfo       = { bg = colors.overlay0, fg = latte.sky },
  FelineLSPStatus     = { bg = colors.overlay0, fg = latte.rosewater },
  FelineLSPStatusIcon = { bg = colors.overlay0, fg = latte.overlay1 },

  -- Separators for LSP area
  FelineLSPSep = { fg = colors.overlay0, bg = colors.base },


  -- Miscellaneous
  FelineFileInfo     = { fg = colors.base, bg = latte.rosewater },
  FelineFolderInfo   = { fg = colors.base, bg = latte.flamingo },
  FelineLineInfo     = { fg = colors.base, bg = latte.sapphire },
  FelinePositionInfo = { fg = colors.base, bg = latte.sky },

  -- Separators for Misc
  FelineFileSep     = { bg = colors.base, fg = latte.rosewater },
  FelineFolderSep   = { bg = colors.base, fg = latte.rosewater },
  FelineLineSep     = { bg = colors.base, fg = latte.sapphire },
  FelinePositionSep = { bg = colors.base, fg = latte.sky },
}

return hlgroups
