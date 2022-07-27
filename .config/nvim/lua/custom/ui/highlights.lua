local M = {}

M.override = {
  LineNr       = { fg = "light_grey" },
  Folded       = { fg = "blue", },
  CmpBorder    = { fg = "orange", },
  CmpDocBorder = { fg = "sun", },
  MatchWord    = { bg = "black", fg = "orange", bold = true },

  IndentBlanklineContextChar = { fg = "nord_blue" },

  TelescopeSelection = { bg = "grey_fg2" },
  -- Separator
  WinSeparator = { fg = "white" },
  NvimTreeWinSeparator = { fg = "white" },

  -- Type = { fg = "green" },

  -- NvimTree
  NvimTreeGitNew = { fg = "green" },
  NvimTreeGitDirty = { fg = "yellow" },
  NvimTreeGitDeleted = { fg = "red" },

  -- Treesitter
  Macro    = { fg = "red", bold = true },
  PreProc  = { fg = "pink", bold = true },
  Comment  = { fg = "yellow", bold = true, italic = true, },
  Type     = { fg = "green1" },
  Constant = { fg = "red" },

  -- StorageClass = { fg = " green1" },
  -- ["@emphasis"]    = { fg = "white", },

  ["@text.emphasis"]       = { italic = true, fg = "white" },
  ["@text.strike"]         = { strikethrough = true, fg = "white" },
  ["@annotation"]          = { fg = "yellow" },
  ["@punctuation.bracket"] = { fg = "purple" },
}

M.add = {
  luaparenError = { link = "Normal" },

  --------Custom Statusline coloring-----------------
  StNormalMode    = { fg = "black2", bg = "blue", bold = true },
  StVisualMode    = { fg = "black2", bg = "cyan", bold = true },
  StInsertMode    = { fg = "black2", bg = "dark_purple", bold = true },
  StTerminalMode  = { fg = "black2", bg = "green", bold = true },
  StNTerminalMode = { fg = "black2", bg = "yellow", bold = true },
  StReplaceMode   = { fg = "black2", bg = "orange", bold = true },
  StConfirmMode   = { fg = "black2", bg = "teal", bold = true },
  StCommandMode   = { fg = "black2", bg = "green", bold = true },
  StSelectMode    = { fg = "black2", bg = "blue", bold = true },

  StInviSep          = { fg = "statusline_bg", bg = "statusline_bg" },
  StNormalModeSep    = { fg = "blue", bg = "statusline_bg", },
  StVisualModeSep    = { fg = "cyan", bg = "statusline_bg", },
  StInsertModeSep    = { fg = "dark_purple", bg = "statusline_bg", },
  StTerminalModeSep  = { fg = "green", bg = "statusline_bg", },
  StNTerminalModeSep = { fg = "yellow", bg = "statusline_bg", },
  StReplaceModeSep   = { fg = "orange", bg = "statusline_bg", },
  StConfirmModeSep   = { fg = "teal", bg = "statusline_bg", },
  StCommandModeSep   = { fg = "green", bg = "statusline_bg", },
  StSelectModeSep    = { fg = "blue", bg = "statusline_bg", },
  -- -- For my own statusline
  -- StNormalModeSep    = { bg = "statusline_bg", },
  -- StInsertModeSep    = { bg = "statusline_bg", },
  -- StTerminalModeSep  = { bg = "statusline_bg", },
  -- StNTerminalModeSep = { bg = "statusline_bg", },
  -- StVisualModeSep    = { bg = "statusline_bg", },
  -- StReplaceModeSep   = { bg = "statusline_bg", },
  -- StConfirmModeSep   = { bg = "statusline_bg", },
  -- StCommandModeSep   = { bg = "statusline_bg", },
  -- StSelectModeSep    = { bg = "statusline_bg", },

  --CurFile
  StCwd        = { bg = "yellow", fg = "black" },
  StFile       = { bg = "orange", fg = "black", bold = true },
  StCwdSep     = { fg = "yellow", bg = "statusline_bg" },
  StFileSep    = { fg = "orange", bg = "statusline_bg" },
  StDirFileSep = { fg = "yellow", bg = "orange" },

  -- Git stuffs
  StGitBranch  = { fg = "purple", bg = "statusline_bg" },
  StGitAdded   = { fg = "green", bg = "statusline_bg" },
  StGitChanged = { fg = "yellow", bg = "statusline_bg" },
  StGitRemoved = { fg = "red", bg = "statusline_bg" },

  -- LSP Stuffs
  -- StLSPProgress = { bg = "statusline_bg", fg = "" },
  StLSPClient   = { bg = "statusline_bg", fg = "blue", bold = true },
  StLSPErrors   = { bg = "statusline_bg", fg = "red" },
  StLSPWarnings = { bg = "statusline_bg", fg = "yellow" },
  StLSPHints    = { bg = "statusline_bg", fg = "purple" },
  StLspInfo     = { bg = "statusline_bg", fg = "cyan" },

  -- File Info stuffs
  StPosition    = { bg = "teal", fg = "black" },
  StPositionSep = { bg = "statusline_bg", fg = "teal" },
  --------Custom Statusline coloring ends------------

  --------Custom Tabline coloring--------------------
  TabLineFill       = { fg = "white", bg = "black2" },
  TabLineBufHidden  = { fg = "black2", bg = "light_grey" },
  TabLineBufActive  = { fg = "black2", bg = "cyan", },
  TabLineCurrentBuf = { fg = "darker_black", bg = "pink", bold = true },
  TabLineModified   = { fg = "green" },
  TabLineCurrentTab = { fg = "darker_black", bg = "red", bold = true },
  TabLineOtherTab   = { fg = "white", bg = "black2" },

  TabLineBufActiveSep  = { fg = "cyan", bg = "black2" },
  TabLineCurrentBufSep = { fg = "pink", bg = "darker_black" },
  TabLineBufHiddenSep  = { fg = "light_grey", bg = "black2" },
  --------Custom Tabline coloring ends---------------

  --------Neotree-----------------------------------
  NeoTreeGitAdded             = { fg = "green", default = true },
  NeoTreeGitModified          = { fg = "yellow" },
  NeoTreeGitUntracked         = { fg = "yellow", italic = true },
  NeoTreeGitDeleted           = { fg = "red" },
  NeoTreeGitConflict          = { fg = "orange" },
  NeoTreeTabActive            = { link = "TabLineCurrentBuf" },
  NeoTreeTabInactive          = { link = "TabLineBufActive" },
  NeoTreeTabSeparatorActive   = { link = "TabLineFill" },
  NeoTreeTabSeparatorInactive = { link = "TabLineFill" },
  --------Neotree ends------------------------------


  --------WinBar coloring----------------------------
  WinBarCurrentFile = { fg = "green", bold = true },
  --------WinBar coloring ends-----------------------

  --------Nvim Notify--------------------------------
  -- NotifyERRORBorder = { fg = "red" },
  -- NotifyWARNBorder  = { fg = "yellow" },
  -- NotifyINFOBorder  = { fg = "nord_blue" },
  -- NotifyDEBUGBorder = { fg = "grey" },
  -- NotifyTRACEBorder = { fg = "grey" },
  -- NotifyERRORIcon   = { fg = "red" },
  -- NotifyWARNIcon    = { fg = "yellow" },
  -- NotifyINFOIcon    = { fg = "nord_blue" },
  -- NotifyDEBUGIcon   = { fg = "grey" },
  -- NotifyTRACEIcon   = { fg = "grey" },
  -- NotifyERRORTitle  = { fg = "red" },
  -- NotifyWARNTitle   = { fg = "yellow" },
  -- NotifyINFOTitle   = { fg = "nord_blue" },
  -- NotifyDEBUGTitle  = { fg = "grey" },
  -- NotifyTRACETitle  = { fg = "grey" },
  --------Nvim Notify ends--------------------------0

  --------Noice-------------------------------------

  --------Noice ends--------------------------------
  LspReferenceText = { link = "IncSearch" },
  LspReferenceRead = { link = "IncSearch" },
  LspReferenceWrite = { link = "IncSearch" },
  LspSignatureActiveParameter = { bg = "green", fg = "black", bold = true, },

  -- Add strikethrough to hlgroups that signifies deprecated stuffs
  cssDeprecated         = { strikethrough = true },
  javaScriptDeprecated  = { strikethrough = true },
  markdownError         = { link = "Normal" },
  ["@text.danger"]      = { fg = "red" },
  ["@text.note"]        = { fg = "blue" },
  ["@text.header"]      = { bold = true },
  ["@text.todo"]        = { fg = "blue" },
  ["@string.special"]   = { fg = "blue", },
  ["@parameter"]        = { fg = "blue" },
  ["@keyword"]          = { fg = "red" },
  ["@variable"]         = { fg = "base08" },
  ["@keyword.return"]   = { fg = "base0E" },
  ["@keyword.function"] = { fg = "teal" },
  ["@constant.macro"]   = { fg = "pink" },
  ["@interface"]        = { link = "Type" },
  ["@type.builtin"]     = { fg = "green1" },
  -- ["@text.underline"]   = { underline = true, fg = "green" },
  Underlined            = { underline = true, fg = "green" },

  NullLsInfoBorder = { link = "FloatBorder" },
}

return M
