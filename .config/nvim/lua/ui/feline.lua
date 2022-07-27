local M = {}


local lsp_severity = vim.diagnostic.severity
local b = vim.b
local fn = vim.fn

local colors  = require("catppuccin.palettes").get_palette()
local ucolors = require("catppuccin.utils.colors")
local latte   = require("catppuccin.palettes.latte")

-- Feline provider
local lsp = require("feline.providers.lsp")

local shortline = false

local icons = {
  left_separator = "",
  right_separator = "",
  bar = "█",
  mode_icon = " ",
}

local element = {
  text = ucolors.vary_color({ latte = latte.base }, colors.surface0),
  bg = ucolors.vary_color({ latte = latte.crust }, colors.surface0),
  diffs = latte.surface0,
  extras = colors.overlay1,
  cur_file = colors.maroon,
  cur_dir = colors.flamingo,
  show_modified = false,
}

local mode_colors = {
  ["n"] = { "NORMAL", colors.lavender },
  ["no"] = { "N-PENDING", colors.lavender },
  ["i"] = { "INSERT", colors.green },
  ["ic"] = { "INSERT", colors.green },
  ["t"] = { "TERMINAL", colors.green },
  ["v"] = { "VISUAL", colors.flamingo },
  ["V"] = { "V-LINE", colors.flamingo },
  [""] = { "V-BLOCK", colors.flamingo },
  ["R"] = { "REPLACE", colors.maroon },
  ["Rv"] = { "V-REPLACE", colors.maroon },
  ["s"] = { "SELECT", colors.maroon },
  ["S"] = { "S-LINE", colors.maroon },
  [""] = { "S-BLOCK", colors.maroon },
  ["c"] = { "COMMAND", colors.peach },
  ["cv"] = { "COMMAND", colors.peach },
  ["ce"] = { "COMMAND", colors.peach },
  ["r"] = { "PROMPT", colors.teal },
  ["rm"] = { "MORE", colors.teal },
  ["r?"] = { "CONFIRM", colors.mauve },
  ["!"] = { "SHELL", colors.green },
}

local is_enabled = function(is_shortline, winid, min_width)
  if is_shortline then return true end
  winid = winid or 0
  return vim.api.nvim_win_get_width(winid) > min_width
end

-- Helper func for git
local get_git_changes = function(opts)
  if not b.gitsigns_head or b.gitsigns_git_status then
    return false
  end
  local enabled = false
  opts = opts or { "added", "changed", "removed" }
  local git_status = b.gitsigns_status_dict
  for _, status in pairs(opts) do
    enabled = enabled or (git_status[status] and git_status[status] > 0)
  end
  return enabled
end


-- Global components
local invi_sep = {
  provider = " ",
  hl = {
    fg = element.bg,
    bg = element.bg,
  }
}

-- ## Statusline components

-- Vi Mode
local vi = {
  left_sep = {
    provider = icons.left_separator,
    hl = function()
      return {
        fg = mode_colors[fn.mode()][2],
        bg = element.bg,
      }
    end,
  },
  right_sep = {
    provider = icons.right_separator,
    hl = function()
      return {
        fg = mode_colors[fn.mode()][2],
        bg = element.bg,
      }
    end,
  },
  icon = {
    provider = icons.mode_icon,
    hl = function()
      return {
        fg = element.text,
        bg = mode_colors[fn.mode()][2],
      }
    end,
  },
  mode = {
    provider = function()
      return " " .. mode_colors[fn.mode()][1] .. " "
    end,
    hl = function()
      return {
        fg   = element.text,
        bg   = mode_colors[fn.mode()][2],
        bold = true,
      }
    end,
  },
}

-- Git
local git = {
  left_sep = {
    provider = icons.left_separator,
    hl = {
      fg = element.diffs,
      bg = element.bg,
    },
    enabled = function() return get_git_changes() end,
  },
  right_sep = {
    provider = icons.right_separator,
    hl = {
      fg = element.diffs,
      bg = element.bg,
    },
    enabled = function() return get_git_changes() end,
  },
  branch = {
    provider = "git_branch",
    enabled = function()
      return is_enabled(shortline, 0, 70) and get_git_changes()
    end,
    hl = {
      fg = element.text,
      bg = element.diffs,
    },
    icons = "  ",
  },
  added = {
    provider = "git_diff_added",
    -- enabled = get_git_changes({ "added" }),
    hl = {
      fg = latte.green,
      bg = element.diffs,
    },
  },
  changed = {
    provider = "git_diff_changed",
    -- enabled = get_git_changes({ "changed" }),
    hl = {
      fg = latte.yellow,
      bg = element.diffs,
    },
  },
  removed = {
    provider = "git_diff_removed",
    -- enabled = get_git_changes({ "removed" }),
    hl = {
      fg = latte.red,
      bg = element.diffs,
    }
  },
}

-- LSP
local diag = {
  progress = {
    provider = function()
      local Lsp = vim.lsp.util.get_progress_messages()[1]
      if Lsp then
        local msg = Lsp.message or ""
        local percentage = Lsp.percentage or 0
        local title = Lsp.title or ""
        local spinners = {
          "",
          "",
          "",
        }
        local success_icon = {
          "",
          "",
          "",
        }

        local ms = vim.loop.hrtime() / 1000000
        local frame = math.floor(ms / 120) % #spinners

        if percentage >= 80 then
          return string.format(" %%<%s %s %s (%s%%%%) ", success_icon[frame + 1], title, msg, percentage)
        end

        return string.format(" %%<%s %s %s (%s%%%%) ", success_icon[frame + 1], title, msg, percentage)
      end

      return ""
    end,
    enabled = is_enabled(shortline, 0, 80),
    hl = {
      bg = element.bg,
      fg = colors.rosewater,
    },
  },
  client = {
    provider = function()
      local clients = {}
      for _, client in pairs(vim.lsp.get_active_clients()) do
        if client.attached_buffers[vim.api.nvim_get_current_buf()] then
          table.insert(clients, client.name)
        end
      end
      local name = table.concat(clients, ",")
      return name
    end,
    enabled = is_enabled(shortline, 0, 100),
    hl = {
      fg = colors.blue,
      bg = element.bg,
    }
  },
  errors = {
    provider = "diagnostic_errors",
    enabled = function()
      return lsp.diagnostics_exist(lsp_severity.ERROR)
    end,

    hl = {
      fg = colors.red,
      bg = element.bg,
    },
    icon = "   ",
  },
  warnings = {
    provider = "diagnostic_warnings",
    enabled = function()
      return lsp.diagnostics_exist(lsp_severity.WARN)
    end,
    hl = {
      fg = colors.yellow,
      bg = element.bg,
    },
    icon = "   ",
  },
  hints = {

    provider = "diagnostic_hints",
    enabled = function()
      return lsp.diagnostics_exist(lsp_severity.HINT)
    end,
    hl = {
      fg = colors.rosewater,
      bg = element.bg,
    },
    icon = " ﯧ ",
  },
  infos = {
    provider = "diagnostic_info",
    enabled = function()
      return lsp.diagnostics_exist(lsp_severity.INFO)
    end,
    hl = {
      fg = colors.sky,
      bg = element.bg,
    },
    icon = "   ",
  },
}

-- File progress
local progress = {
  left_sep = {
    provider = icons.left_separator,
    hl = {
      fg = colors.sky,
      bg = element.bg,
    }
  },
  right_sep = {
    provider = icons.right_separator,
    hl = {
      fg = colors.sky,
      bg = element.bg,
    }
  },
  line_percentage = {
    provider = function()
      local current_line = fn.line(".")
      local total_line = fn.line("$")

      if current_line == 1 then
        return " Top "
      elseif current_line == fn.line("$") then
        return " Bot "
      end
      local result, _ = math.modf((current_line / total_line) * 100)
      return " " .. result .. "%% "
    end,
    hl = {
      fg = element.text,
      bg = colors.sky,
    }
  },
  position = {
    provider = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      local line_text = vim.api.nvim_get_current_line()
      -- Get the text before the cursor in the current line
      local before_cursor = line_text:sub(1, col)

      -- Replace tabs with the equivalent amount of spaces according to the value of 'tabstop'
      before_cursor = before_cursor:gsub("\t", string.rep(" ", vim.bo.tabstop))

      -- Turn col from byteindex to column number and make it start from 1
      col = vim.str_utfindex(before_cursor) + 1
      return string.format("%-3d:%3d", line, col)
    end,
    hl = {
      fg = element.text,
      bg = colors.sky,
    },
    enabled = function() return fn.expand("%") ~= "" end,
  },
}

-- File
local file_info = {
  dir = {
    provider = function()
      local dir_name = fn.fnamemodify(vim.fn.getcwd(), ":t")
      return "  " .. dir_name .. " "
    end,
    enabled = is_enabled(shortline, 0, 80),
    hl = {
      fg = element.text,
      bg = element.cur_dir,
    },
    left_sep = {
      str = icons.left_separator,
      hl = {
        fg = element.cur_dir,
        bg = element.bg,
      },
    },
    right_sep = {
      str = icons.right_separator,
      hl = function()
        return {
          fg = element.cur_dir,
          bg = fn.expand("%") == "" and element.bg or element.cur_file,
        }
      end
    },
  },
  name = {
    provider = function()
      local filename = fn.expand("%:t")
      local extension = fn.expand("%:e")
      local icon = require("nvim-web-devicons").get_icon(filename, extension)
      return icon ~= nil and (" " .. icon .. " " .. filename .. " ") or " "
    end,
    enabled = function()
      return fn.expand("%") ~= ""
    end,
    hl = {
      fg = element.text,
      bg = element.cur_file,
    },
    right_sep = {
      str = icons.right_separator,
      hl = {
        fg = element.cur_file,
        bg = element.bg,
      }
    }
  },
}


-- ## End Statusline components

local left = {
  invi_sep,
  vi.left_sep, vi.icon, vi.mode, vi.right_sep,
  invi_sep,
  file_info.dir, file_info.name,
  invi_sep,
  git.left_sep, git.branch, git.added, git.changed, git.removed, git.right_sep,
  invi_sep,
}
local middle = {
  diag.progress,
  diag.errors, diag.warnings, diag.infos, diag.hints,
  invi_sep,
}
local right = {
  invi_sep,
  diag.client,
  invi_sep,
  progress.left_sep, progress.position, progress.right_sep,
  invi_sep,
}

M.statusline = function()
  require("feline").setup({
    components = {
      active = { left, middle, right },
      inactive = {},
    },
  })
end
return M
