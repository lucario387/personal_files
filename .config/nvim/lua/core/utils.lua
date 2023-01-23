---Workaround to use Base46 outside NvChad :wink:
local M = {}

vim.g.nvchad_theme = "vscode_dark"

--- This is the base46-related configs
--- Aka all the ui table
M.load_config = function()
  return ({
    ui = {
      hl_override = {
        LineNr = { fg = "light_grey" },
        Folded = { fg = "blue" },
        MatchWord = { bg = "black", fg = "orange", bold = true },
        Visual = { bg = "#83b7e2" },

        IndentBlanklineContextChar = { fg = "nord_blue" },

        TelescopeSelection = { bg = "grey_fg2" },

        -- Separator
        WinSeparator = { fg = "white" },
        NvimTreeWinSeparator = { fg = "white" },

        -- Type = { fg = "green" },

        -- nvim-cmp
        CmpBorder = { fg = "orange" },
        CmpDocBorder = { fg = "sun" },
        CmpItemKindFolder = { fg = "blue" },

        -- NvimTree
        NvimTreeGitNew = { fg = "green" },
        NvimTreeGitDirty = { fg = "yellow" },
        NvimTreeGitDeleted = { fg = "red" },

        -- Syntax
        Macro = { fg = "red", bold = true },
        PreProc = { fg = "pink", bold = true },
        Comment = { fg = "yellow", bold = true, italic = true },
        Type = { fg = "green1" },
        Constant = { fg = "red" },
        Structure = { fg = "green1" },
        Identifier = { fg = "purple" },

        -- Gitsigns
        DiffChange = { fg = "yellow" },
        DiffAdd = { fg = "green" },
        DiffText = { fg = "white", bg = "red", bold = true },

        -- StorageClass = { fg = " green1" },
        -- ["@emphasis"]    = { fg = "white", },

        -- Treesitter
        ["@text.emphasis"] = { italic = true, fg = "white" },
        ["@text.strike"] = { strikethrough = true, fg = "white" },
        ["@annotation"] = { fg = "yellow" },
        -- ["@punctuation.bracket"] = { fg = "purple" },
        ["@constructor"] = { fg = "yellow" },

        -- Semantics token
        ["@namespace"] = { fg = "teal" },
      },
      hl_add = {
        luaparenError = { link = "Normal" },

        ------------------------LspSaga------------------------------------
        SagaBorder     = { fg = "blue" },
        HoverNormal    = { fg = "white" },
        CodeActionText = { fg = "white" },

        ------------------------Custom Statusline coloring-----------------
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
        StNormalModeSep    = { fg = "blue", bg = "statusline_bg" },
        StVisualModeSep    = { fg = "cyan", bg = "statusline_bg" },
        StInsertModeSep    = { fg = "dark_purple", bg = "statusline_bg" },
        StTerminalModeSep  = { fg = "green", bg = "statusline_bg" },
        StNTerminalModeSep = { fg = "yellow", bg = "statusline_bg" },
        StReplaceModeSep   = { fg = "orange", bg = "statusline_bg" },
        StConfirmModeSep   = { fg = "teal", bg = "statusline_bg" },
        StCommandModeSep   = { fg = "green", bg = "statusline_bg" },
        StSelectModeSep    = { fg = "blue", bg = "statusline_bg" },
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
        StGitBranch  = { bg = "light_grey", fg = "purple" },
        StGitAdded   = { bg = "light_grey", fg = "green" },
        StGitChanged = { bg = "light_grey", fg = "yellow" },
        StGitRemoved = { bg = "light_grey", fg = "red" },
        StGitSep     = { bg = "statusline_bg", fg = "light_grey" },

        -- LSP Stuffs
        -- StLSPProgress = { bg = "statusline_bg", fg = "" },
        StLSPClient   = { bg = "statusline_bg", fg = "blue", bold = true },
        StLSPDiagSep  = { bg = "statusline_bg", fg = "light_grey" },
        StLSPErrors   = { bg = "light_grey", fg = "red" },
        StLSPWarnings = { bg = "light_grey", fg = "yellow" },
        StLSPHints    = { bg = "light_grey", fg = "purple" },
        StLspInfo     = { bg = "light_grey", fg = "cyan" },

        -- File Info stuffs
        StPosition    = { bg = "teal", fg = "black" },
        StPositionSep = { bg = "statusline_bg", fg = "teal" },
        --------Custom Statusline coloring ends------------

        --------Custom Tabline coloring--------------------
        TabLineFill       = { underline = true, fg = "white", bg = "darker_black" },
        TabLineBufHidden  = { underline = true, fg = "white", bg = "light_grey" },
        TabLineBufActive  = { fg = "white", bg = "teal", bold = true },
        TabLineCurrentBuf = { fg = "white", bg = "pink", bold = true },
        TabLineModified   = { fg = "green" },
        TabLineCurrentTab = { underline = true, fg = "white", bg = "red", bold = true },
        TabLineOtherTab   = { underline = true, fg = "white", bg = "black2" },

        TabLineBufActiveSep  = { underline = true, fg = "white", bg = "black2" },
        TabLineCurrentBufSep = { underline = true, fg = "white", bg = "black2" },
        TabLineBufHiddenSep  = { underline = true, fg = "white", bg = "black2" },
        --- Good old colorful statusline
        -- TabLineBufHidden  = { fg = "black2", bg = "light_grey" },
        -- TabLineBufActive  = { fg = "black2", bg = "cyan", },
        -- TabLineCurrentBuf = { fg = "darker_black", bg = "pink", bold = true },
        -- TabLineModified   = { fg = "green" },
        -- TabLineCurrentTab = { fg = "darker_black", bg = "red", bold = true },
        -- TabLineOtherTab   = { fg = "white", bg = "black2" },
        --
        -- TabLineBufActiveSep  = { fg = "cyan", bg = "black2" },
        -- TabLineCurrentBufSep = { fg = "pink", bg = "darker_black" },
        -- TabLineBufHiddenSep  = { fg = "light_grey", bg = "black2" },
        --------Custom Tabline coloring ends---------------

        --------WinBar coloring----------------------------
        WinBarCurrentFile = { fg = "green", bold = true },
        --------WinBar coloring ends-----------------------

        --------Noice-------------------------------------

        --------Noice ends--------------------------------
        -- LspReferenceText = { link = "IncSearch" },
        -- LspReferenceRead = { link = "IncSearch" },
        -- LspReferenceWrite = { link = "IncSearch" },
        -- LspSignatureActiveParameter = { bg = "green", fg = "black", bold = true, },

        -- Add strikethrough to hlgroups that signifies deprecated stuffs
        cssDeprecated         = { strikethrough = true },
        javaScriptDeprecated  = { strikethrough = true },
        markdownError         = { link = "Normal" },
        ["@text.danger"]      = { fg = "red" },
        ["@text.note"]        = { fg = "blue" },
        ["@text.header"]      = { bold = true },
        ["@text.diff.add"]    = { fg = "green" },
        ["@text.diff.delete"] = { fg = "red" },
        ["@text.todo"]        = { fg = "blue" },
        ["@string.special"]   = { fg = "blue" },
        ["@parameter"]        = { fg = "blue" },
        ["@keyword"]          = { fg = "red" },
        ["@variable"]         = { fg = "base08" },
        ["@keyword.return"]   = { fg = "base0E" },
        ["@keyword.function"] = { fg = "teal" },
        ["@constant.macro"]   = { fg = "pink" },
        ["@interface"]        = { link = "Type" },
        ["@type.builtin"]     = { fg = "green1" },
        ["@type.qualifier"]   = { fg = "teal" },
        ["@storageclass"]     = { fg = "teal" },
        -- ["@text.underline"]   = { underline = true, fg = "green" },
        Underlined            = { underline = true, fg = "green" },

        NullLsInfoBorder = { link = "FloatBorder" },
      },

      changed_themes = {},
      theme_toggle = { "vscode_dark", "catppuccin_latte" },
      theme = "vscode_dark", -- default theme

      transparency = false,

      -- cmp themeing
      cmp = {
        icons = true,
        lspkind_text = true,
        style = "default", -- default/flat_light/flat_dark/atom/atom_colored
        border_color = "grey_fg", -- only applicable for "default" style, use color names from base30 variables
        selected_item_bg = "colored", -- colored / simple
      },
      statusline = {
        theme = "default",
      },

      cheatsheet = {
        theme = "grid", -- simple/grid
      },
    }
  })

    ------------------------------- base46 -------------------------------------
    -- hl = highlights
end

return M
