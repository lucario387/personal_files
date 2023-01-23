local fn = vim.fn
local api = vim.api
local buf_is_valid = require("config.ui.tabline.utils").buf_is_valid
-- local dev_icons = require("nvim-web-devicons")

require("mappings").tabline()
local PADDING_SIZE = 2
local ICON_SIZE = 2
local TAB_SIZE = 3
local FILENAME_LENGTH = 20

local auto_true_filetypes = {
  "NvimTree",
  "mind",
  -- "help",
  -- "qf",
}

-- local padding = {
--   -- left = "",
--   left  = "",
--   right = "",
-- }

local padding = {
  left = "",
  right = " ",
}

---Create a new hlgroup
---From group1 fg and group2 bg
---@param group1 string
---@param group2 string
---@return string hl_group name of the new hlgroup
local new_hl = function(group1, group2)
  local hl1 = vim.api.nvim_get_hl_by_name(group1, true)
  local hl2 = vim.api.nvim_get_hl_by_name(group2, true)
  local new_hlgroup = "TabLine" .. group1 .. group2
  api.nvim_set_hl(0, new_hlgroup, { fg = hl1.foreground, bg = hl2.background, underline = hl1.underline })
  return new_hlgroup
end

local hl_str = function(hlgroup, str)
  return "%#" .. hlgroup .. "#" .. str
end

local get_ft_win_width = function(ft)
  for _, winnr in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.bo[vim.api.nvim_win_get_buf(winnr)].ft == ft then
      return vim.api.nvim_win_get_width(winnr)
    end
  end
  return 0
end

local generate_buf_str = function(v, bufnr)
  if not buf_is_valid(v) then
    return { str = "", len = 0 }
  end
  local bufname = vim.api.nvim_buf_get_name(v)
  bufname = #bufname > 0 and bufname or "No Name"
  local filename = vim.fn.fnamemodify(bufname, ":t")
  -- local extension = vim.fn.fnamemodify(bufname, ":e")
  local hlgroup = (vim.fn.getbufinfo(v)[1].hidden == 1 or not vim.tbl_contains(vim.t.bufs, v)) and "TabLineBufHidden"
    or "TabLineBufActive"
  hlgroup = (v == bufnr) and "TabLineCurrentBuf" or hlgroup

  local border_str_left = hl_str(hlgroup .. "Sep", padding.left)
  local border_str_right = hl_str(hlgroup .. "Sep", padding.right)

  -- local icon, icon_hl = dev_icons.get_icon(filename, extension, { default = true })
  -- local icon_str = hl_str(new_hl(icon_hl, hlgroup), icon .. " ")

  if #filename % 2 == 1 then
    filename = filename .. ""
  end
  if #filename > FILENAME_LENGTH then
    filename = string.sub(filename, 1, FILENAME_LENGTH - 2) .. ".."
  end

  local filename_str = hl_str(hlgroup, filename)

  local padding_len = math.min(PADDING_SIZE, FILENAME_LENGTH - #filename)
  local padding_str = hl_str(hlgroup, string.rep(" ", padding_len / 2))

  local modified_str = vim.api.nvim_buf_get_option(v, "modified") and hl_str(new_hl("TabLineModified", hlgroup), " ")
    or ""
  local modified_len = vim.api.nvim_buf_get_option(v, "modified") and 2 or 0

  return {
    str = border_str_left .. padding_str .. filename_str .. modified_str .. padding_str .. border_str_right,
    len = 2 + padding_len + ICON_SIZE + modified_len + #filename,
  }
  -- return {
  --   str = border_str_left .. padding_str .. icon_str .. filename_str .. modified_str .. padding_str .. border_str_right,
  --   len = 2 + padding_len + ICON_SIZE + modified_len + #filename
  -- }
end

local M = {}

local pad_str = function(amount)
  return hl_str("TabLineFill", string.rep(" ", amount - 1))
end

local padding_ft = function(ft)
  local width = get_ft_win_width(ft)
  if width <= 0 then
    return ""
  end
  return hl_str("TabLineFill", string.rep(" ", get_ft_win_width(ft)))
end

local bufferlist = function()
  local tabnr = vim.api.nvim_get_current_tabpage()
  local bufnr = vim.api.nvim_get_current_buf()
  local buflist = vim.t[tabnr].bufs
  if not buflist then
    return ""
  end
  -- local str = "Run: " .. count + 1 .. ", Tab: " .. tabnr .. ", buflist:"
  -- count = count + 1
  -- for _, v in pairs(buflist) do
  --   str = str .. " " .. v
  -- end
  -- vim.pretty_print(str)
  -- if true then return "" end
  local rendered_buflist = {}
  local remaining_columns = vim.o.columns - get_ft_win_width("NvimTree") - #vim.api.nvim_list_tabpages() * TAB_SIZE
  local has_current_bufnr = vim.tbl_contains(auto_true_filetypes, vim.api.nvim_buf_get_option(bufnr, "ft"))
  local current_buflen = 0

  for _, v in ipairs(buflist) do
    if current_buflen + (FILENAME_LENGTH + PADDING_SIZE + ICON_SIZE + 2) > remaining_columns then
      if has_current_bufnr then
        break
      end
      current_buflen = current_buflen - rendered_buflist[1].len
      table.remove(rendered_buflist, 1)
    end
    has_current_bufnr = has_current_bufnr or (v == bufnr)
    local buf_info = generate_buf_str(v, bufnr)
    current_buflen = current_buflen + buf_info.len

    table.insert(rendered_buflist, { str = buf_info.str, len = buf_info.len })
  end

  local result = ""
  for i, _ in ipairs(rendered_buflist) do
    result = result .. rendered_buflist[i].str
  end

  return result
end

local tablist = function()
  local tablist = vim.api.nvim_list_tabpages()
  local tabnr = vim.api.nvim_get_current_tabpage()
  if #tablist < 2 then
    return ""
  end
  local result = ""

  for i, v in ipairs(tablist) do
    if v == tabnr then
      result = result .. hl_str("TabLineCurrentTab", string.format(" %d ", i))
    else
      result = result .. hl_str("TabLineOtherTab", string.format(" %d ", i))
    end
  end
  return result
end

M.draw = function()
  return table.concat({
    padding_ft("NvimTree"),
    bufferlist(),
    pad_str(1),
    "%=",
    tablist(),
    -- "TEST"
  })
end
return M
