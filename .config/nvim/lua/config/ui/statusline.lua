local M = {}

local fn = vim.fn
local api = vim.api

local HOME = os.getenv("HOME")
local MINIMUM_SIZE = 95
local FILENAME_SIZE = 18

local modes = {
  ["n"] = { "NORMAL", "StNormalMode" },
  ["niI"] = { "NORMAL i", "StNormalMode" },
  ["niR"] = { "NORMAL r", "StNormalMode" },
  ["niV"] = { "NORMAL v", "StNormalMode" },
  ["no"] = { "N-PENDING", "StNormalMode" },
  ["i"] = { "INSERT", "StInsertMode" },
  ["ic"] = { "INSERT (completion)", "StInsertMode" },
  ["ix"] = { "INSERT completion", "StInsertMode" },
  ["t"] = { "TERMINAL", "StTerminalMode" },
  ["nt"] = { "NTERMINAL", "StNTerminalMode" },
  ["v"] = { "VISUAL", "StVisualMode" },
  ["V"] = { "V-LINE", "StVisualMode" },
  ["Vs"] = { "V-LINE (Ctrl O)", "StVisualMode" },
  [""] = { "V-BLOCK", "StVisualMode" },
  ["R"] = { "REPLACE", "StReplaceMode" },
  ["Rv"] = { "V-REPLACE", "StReplaceMode" },
  ["s"] = { "SELECT", "StSelectMode" },
  ["S"] = { "S-LINE", "StSelectMode" },
  [""] = { "S-BLOCK", "StSelectMode" },
  ["c"] = { "COMMAND", "StCommandMode" },
  ["cv"] = { "COMMAND", "StCommandMode" },
  ["ce"] = { "COMMAND", "StCommandMode" },
  ["r"] = { "PROMPT", "StConfirmMode" },
  ["rm"] = { "MORE", "StConfirmMode" },
  ["r?"] = { "CONFIRM", "StConfirmMode" },
  ["!"] = { "SHELL", "StTerminalMode" },
}

-- local hidden_filetypes = {
--   "NvimTree",
--   "neo-tree",
--   "mind",
-- }

local invi_sep = "%#StInviSep# "
local padding_ft = function(ft)
  if vim.o.columns < MINIMUM_SIZE then
    return ""
  end
  for _, win in pairs(api.nvim_tabpage_list_wins(0)) do
    if vim.bo[api.nvim_win_get_buf(win)].ft == ft then
      local size = math.min(30, api.nvim_win_get_width(win) + 1)
      if vim.o.columns > MINIMUM_SIZE + size then
        return "%#StInviSep#" .. string.rep(" ", size, "")
      end
    end
  end
  return ""
end

local mode = function()
  local m = api.nvim_get_mode().mode
  local current_mode = "%#" .. modes[m][2] .. "# " .. modes[m][1]
  local left_sep = "%#" .. modes[m][2] .. "Sep#"
  local right_sep = "%#" .. modes[m][2] .. "Sep#"
  return left_sep .. current_mode .. right_sep
end

local cwd = function()
  local left_sep = "%#StCwdSep#"
  local dir_name = (fn.getcwd() == HOME) and "%#StCwd# $HOME" or "%#StCwd# " .. fn.fnamemodify(fn.getcwd(), ":t")
  return (vim.o.columns > MINIMUM_SIZE) and left_sep .. dir_name or ""
end

local file_name = function()
  local filename = fn.expand("%:t")
  if filename == "" or #filename >= FILENAME_SIZE then
    return (vim.o.columns > MINIMUM_SIZE) and "%#StCwdSep#" or ""
  end
  local extension = fn.expand("%:e")
  local icon = require("nvim-web-devicons").get_icon(filename, extension)
  icon = (icon ~= nil) and icon or ""
  local left_sep = (vim.o.columns > MINIMUM_SIZE) and "%#StDirFileSep#" or "%#StFileSep#"
  local right_sep = "%#StFileSep#"
  local file_info = "%#StFile# " .. icon .. " " .. filename
  return left_sep .. file_info .. right_sep
end

local git = function()
  ---@diagnostic disable-next-line: undefined-field
  if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
    return ""
  end
  ---@diagnostic disable-next-line: undefined-field
  local git_status = vim.b.gitsigns_status_dict
  local branch = "%#StGitBranch# " .. git_status.head
  local added = (git_status.added and git_status.added ~= 0) and ("%#StGitAdded#  " .. git_status.added) or ""
  local changed = (git_status.changed and git_status.changed ~= 0) and ("%#StGitChanged#  " .. git_status.changed)
    or ""
  local removed = (git_status.removed and git_status.removed ~= 0) and ("%#StGitRemoved#  " .. git_status.removed)
    or ""
  return "%#StGitSep#" .. branch .. added .. changed .. removed .. "%#StGitSep#"
end

-- M.session_status = function()
--   return vim.g.persisting == true
--     and "%#StSessionStatus#  "
--     or "%#StSessionStatus#  "
-- end

local lsp_diagnostics = function()
  if #vim.lsp.get_active_clients({ bufnr = 0 }) == 0 then
    return ""
  end
  local num_errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local num_warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  local num_hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
  local num_infos = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  return string.format(
    "%%#StLSPDiagSep#%%#StLSPErrors# %d%%#StLSPWarnings# %d%%#StLSPHints# %d%%#StLSPInfo# %d%%#StLSPDiagSep#",
    num_errors,
    num_warnings,
    num_hints,
    num_infos
  )
end

local lsp_clients = function()
  local clients = {}
  for _, client in pairs(vim.lsp.get_active_clients()) do
    if client.attached_buffers[api.nvim_get_current_buf()] then
      clients[#clients + 1] = client.name
    end
  end
  local name = table.concat(clients, ",")
  return (vim.o.columns > MINIMUM_SIZE) and "%#StLSPClient#" .. name .. " " or "%#StLSPClient#  LSP "
end

local position = function()
  if not vim.api.nvim_buf_get_option(0, "modifiable") then
    return ""
  end
  local left_sep = "%#StPositionSep#"
  local right_sep = "%#StPositionSep#"
  local line, col = unpack(api.nvim_win_get_cursor(0))
  local line_text = api.nvim_get_current_line()
  -- Get the text before the cursor in the current line
  local before_cursor = line_text:sub(1, col)
  -- Replace tabs with the equivalent amount of spaces according to the value of 'tabstop'
  before_cursor = before_cursor:gsub("\t", string.rep(" ", vim.bo.tabstop))
  -- Turn col from byteindex to column number and make it start from 1
  col = vim.str_utfindex(before_cursor) + 1

  local cursor_position = "%#StPosition#" .. string.format("%-3d:%3d", line, col)
  return left_sep .. cursor_position .. right_sep
end

local current_time = function()
  return "%#StatusLine#" .. vim.fn.strftime("%H:%M:%S") .. " "
end

M.draw = function()
  if vim.o.columns > MINIMUM_SIZE then
    return table.concat({
      mode(),
      invi_sep,
      cwd(),
      file_name(),
      invi_sep,
      lsp_diagnostics(),
      lsp_clients(),
      -- "%=",
      -- lsp_progress(),
      -- lsp_clients(),
      "%=",
      git(),
      invi_sep,
      -- current_time(),
      -- session_status(),
      position(),
    })
  else
    return table.concat({
      mode(),
      invi_sep,
      cwd(),
      file_name(),
      -- git(),
      "%=",
      -- current_time(),
      -- session_status(),
      position(),
    })
  end
end

return M
