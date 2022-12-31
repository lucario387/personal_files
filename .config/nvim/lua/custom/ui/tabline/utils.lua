local add_clean_buf = function(tabnr)
  local buflist = vim.t[tabnr].bufs
  for i, bufnr in ipairs(buflist) do
    if (not vim.bo[bufnr].modified) and (vim.bo[bufnr].ft == "" or vim.bo[bufnr].ft == nil) then
      table.remove(buflist, i)
    end
  end
  return buflist
end
local disabled_buftypes = {
  "terminal",
  "prompt",
}


local M = {}


function M.buf_is_valid(bufnr)
  if not bufnr or bufnr < 1 then return false end

  return (not vim.tbl_contains(disabled_buftypes, vim.api.nvim_buf_get_option(bufnr, "buftype")))
    and vim.api.nvim_buf_is_valid(bufnr)
    and vim.api.nvim_buf_get_option(bufnr, "buflisted")
end

---Wrapper around `vim.api.nvim_list_bufs()`
function M.get_list_bufs()
  local buflist = {}
  for _, bufnr in pairs(vim.api.nvim_list_bufs()) do
    if M.buf_is_valid(bufnr) then
      table.insert(buflist, bufnr)
    end
  end
  return buflist
end

function M.add_buffer(bufnr)
  local tabnr = vim.api.nvim_get_current_tabpage()
  if vim.t[tabnr].bufs == nil then
    vim.t[tabnr].bufs = { bufnr }
    return
  end

  local buflist = add_clean_buf(tabnr)

  -- check for duplicates
  if not vim.tbl_contains(buflist, bufnr) and M.buf_is_valid(bufnr) then
    table.insert(buflist, bufnr)
    vim.t[tabnr].bufs = buflist
  end
end

function M.remove_buf_from_other_tab(bufnr, tabnr)
  for _, i in pairs(vim.api.nvim_list_tabpages()) do
    if i ~= tabnr then
      local buflist = vim.t[i].bufs
      for j, v in ipairs(buflist) do
        if v == bufnr then
          table.remove(buflist, j)
        end
      end
      vim.t[i].bufs = buflist
    end
  end
end

--- Remove buf from tablist
--- @param bufnr integer
function M.delete_buffer(bufnr)
  local tabnr = vim.api.nvim_get_current_tabpage()
  -- for _, tabnr in ipairs(vim.api.nvim_list_tabpages()) do
  local buflist = vim.t[tabnr].bufs
  if buflist then
    for i, v in ipairs(buflist) do
      if v == bufnr then
        table.remove(buflist, i)
        vim.t[tabnr].bufs = buflist
        break
      end
    end
  end
  -- end
end

--- Usually this is triggered on **TabLeave**
--- @param tabnr number
function M.set_tab_bufs_unlisted(tabnr)
  if not vim.t[tabnr].bufs then return end
  for _, bufnr in pairs(vim.t[tabnr].bufs) do
    vim.api.nvim_buf_set_option(bufnr, "buflisted", false)
  end
end

--- Usually trigger on **TabEnter**
--- @param tabnr number
function M.set_tab_bufs_listed(tabnr)
  if not vim.t[tabnr].bufs then return end
  for _, bufnr in pairs(vim.t[tabnr].bufs) do
    vim.api.nvim_buf_set_option(bufnr, "buflisted", true)
  end
end

--------Movements------------------------
function M.next_buffer(bufnr, tabnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  tabnr = tabnr or vim.api.nvim_get_current_tabpage()
  local buflist = vim.t[tabnr].bufs
  for i, v in ipairs(buflist) do
    if v == bufnr then
      vim.api.nvim_set_current_buf(i == #buflist and buflist[1] or buflist[i + 1])
    end
  end
end

function M.prev_buffer(bufnr, tabnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  tabnr = tabnr or vim.api.nvim_get_current_tabpage()
  local buflist = vim.t[tabnr].bufs
  for i, v in ipairs(buflist) do
    if v == bufnr then
      vim.api.nvim_set_current_buf(i == 1 and buflist[#buflist] or buflist[i - 1])
    end
  end
end

function M.close_buffer(bufnr, tabnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  tabnr = tabnr or vim.api.nvim_get_current_tabpage()

  if (vim.t[tabnr].bufs == nil or #vim.t[tabnr].bufs == 1) and #vim.api.nvim_list_tabpages() > 1 then
    -- M.delete_buffer(bufnr)
    vim.cmd.tabclose()
    return
  end

  if #vim.t[tabnr].bufs > 1 then
    M.prev_buffer(bufnr, tabnr)
  end
  -- M.delete_buffer(bufnr)
  vim.cmd("confirm bd " .. bufnr)
end

return M
