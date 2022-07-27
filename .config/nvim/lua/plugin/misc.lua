local M = {}

M.bufferline = function()

end

M.signature = function()
  local present, lsp_signature = pcall(require, "lsp_signature")
  if not present then
    return
  end
  local options = {
    bind = true,
    doc_lines = 20,
    floating_window = true,
    floating_window_above_cur_line = false,
    check_completion_visible = true,
    -- always_trigger = true,
    fix_pos = false,
    hint_enable = true,
    hint_prefix = " ",
    hint_scheme = "String",
    hi_parameter = "Search",
    max_height = 15,
    max_width = 80, -- max_width of signature floating_window, line will be wrapped if exceed max_width
    handler_opts = {
      border = "single", -- double, single, shadow, none
    },
    zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
    padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
  }
  lsp_signature.setup(options)
end

M.autopairs = function()
  local present1, autopairs = pcall(require, "nvim-autopairs")
  local present2, cmp = pcall(require, "cmp")

  if not present1 and present2 then
    return
  end
  local options = {
    fast_wrap = {},
    disable_filetype = { "TelescopePrompt", "vim" },
  }


  autopairs.setup(options)
  local cmp_autopairs = require "nvim-autopairs.completion.cmp"

  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

M.sessions = function()
  local present, sessions = pcall(require, "persisted")
  if not present then
    return
  end
  sessions.setup({
    dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
    autosave = true,
    allowed_dirs = {
      "~/.config",
      "~/Desktop",
      "~/dotfiles",
    },
    ignored_dirs = {
      vim.fn.stdpath("data") .. "/sessions",
    },
    after_save = function()
      vim.notify("Session saved!", "INFO")
    end
  })
end


M.clip_image = function()
  local present, clipboard_image = pcall(require, "clipboard-image")
  if not present then
    return
  end
  clipboard_image.setup {
    default = {
      img_dir = { "%:p:h", "img" },
      img_name = function()
        -- vim.fn.inputsave()
        -- local name = vim.fn.input("Name: ")
        -- vim.fn.inputrestore()

        -- if name == nil or name == '' then
        --     return os.date('%y-%m-%d-%H-%M-%S')
        -- end
        -- return name
        return os.date("%y-%m-%d-%H-%M-%S")
      end,
    },
    markdown = {
      img_handler = function(img)
        vim.cmd "normal! f[a"
        -- vim.fn.inputsave()
        -- local text = vim.fn.input("Placeholder Text: ")
        -- vim.fn.inputrestore()
        -- if text == nil or text == "" then
        --   vim.cmd("normal! f[")
        --   vim.cmd("normal! a" .. img.name)
        -- else
        --   vim.cmd("normal! f[")
        --   vim.cmd("normal! a" .. text) -- Append placeholder text, no need to care about image name
        -- end
      end
    }
  }
end

M.comment = function()
  local present, Comment = pcall(require, "Comment")

  if not present then
    return
  end
  Comment.setup({
    extra = {
      eol = "gca",
    }
  })
end

M.todo_highlight = function()
  local present, todo_comments = pcall(require, "todo-comments")
  if not present then
    return
  end

  todo_comments.setup({

    signs = true, -- show icons in the signs column
    sign_priority = 8, -- sign priority
    -- keywords recognized as todo comments
    keywords = {
      FIX = {
        icon = " ", -- icon used for the sign, and in search results
        color = "error", -- can be a hex color, or a named color (see below)
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
        -- signs = false, -- configure signs for some keywords individually
      },
      TODO = { icon = " ", color = "info" },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
    },
    merge_keywords = true, -- when true, custom keywords will be merged with the defaults
    -- highlighting of the line containing the todo comment
    -- * before: highlights before the keyword (typically comment characters)
    -- * keyword: highlights of the keyword
    -- * after: highlights after the keyword (todo text)
    highlight = {
      before = "", -- "fg" or "bg" or empty
      keyword = "wide", -- "fg", "bg", "wide" or empty.
      after = "fg", -- "fg" or "bg" or empty
      pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
      comments_only = true, -- uses treesitter to match keywords in comments only
      -- max_line_len = 400, -- ignore lines longer than this
      exclude = {
        "NvimTree",
        "alpha",
        "vim", "lspinfo", "lsp-installer",
        "help",
        "packer",
        "toggleterm",
        "dashboard",
      }, -- list of file types to exclude highlighting
    },
    -- list of named colors where we try to extract the guifg from the
    -- list of hilight groups or use the hex color if hl not found as a fallback
    colors = {
      error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
      warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
      info = { "DiagnosticInfo", "#2563EB" },
      hint = { "DiagnosticHint", "#10B981" },
      default = { "Identifier", "#7C3AED" },
    },
    search = {
      command = "rg",
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      },
      -- regex that will be used to match keywords.
      -- don't replace the (KEYWORDS) placeholder
      pattern = [[\b(KEYWORDS):]], -- ripgrep regex
      -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
    },
  })
end



M.gitsigns = function()
  local present, gitsigns = pcall(require, "gitsigns")

  if not present then
    return
  end


  local options = {
    signs = {
      add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
      change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
      delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
      topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
      changedelete = { hl = "DiffChangeDelete", text = "~", numhl = "GitSignsChangeNr" },
    },
  }

  gitsigns.setup(options)
end


M.luasnip = function()
  local present, luasnip = pcall(require, "luasnip")
  if not present then
    return
  end

  local options = {
    history = true,
    updateevents = "TextChanged,TextChangedI",
  }

  luasnip.config.set_config(options)
  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.g.luasnippets_path, } })

  vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
      if require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
          and not require("luasnip").session.jump_active
      then
        require("luasnip").unlink_current()
      end
    end,
  })

end
return M
