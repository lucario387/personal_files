-- Port of https://github.com/knubie/vim-kitty-navigator/blob/master/plugin/kitty_navigator.vim
-- Remove some functionalities from it
-- Since I don't usually use it enough
if vim.g.loaded_kitty_navigator then
  return
end

vim.g.loaded_kitty_navigator = true

-- vim.g.last_kitty_pane = false
--
-- vim.api.nvim_create_autocmd({ "TabEnter", "WinEnter", "FocusGained" }, {
--   group = vim.api.nvim_create_augroup("KittyMovement", {}),
--   callback = function()
--     vim.g.last_kitty_pane = false
--   end
-- })

local allowed_directions = {
  ["h"] = "left",
  ["j"] = "bottom",
  ["k"] = "top",
  ["l"] = "right",
}

---Run a command using io.popen
---@param command string
local run_command = function(command)
  local handle = assert(io.popen(command))
  handle:close()
end

local kitty_command = function(args)
  local command = string.format("kitty @ " .. args)
  run_command(command)
end

---@param direction string
local navigate = function(direction)
  vim.cmd("wincmd " .. direction)
end

---@param direction string
local kitty_navigate = function(direction)
  if not allowed_directions[direction] then
    return
  end

  local winnr = vim.api.nvim_get_current_win()
  -- if not vim.g.last_kitty_pane then
  navigate(direction)
  -- end

  if winnr == vim.api.nvim_get_current_win() then
    kitty_command("kitten neighboring_window.py " .. allowed_directions[direction])
    -- vim.g.last_kitty_pane = true
  else
    -- vim.g.last_kitty_pane = false
  end
end

-- vim.api.nvim_create_user_command("KittyMoveLeft", function()
--   kitty_navigate("h")
-- end, {})
-- vim.api.nvim_create_user_command("KittyMoveDown", function()
--   kitty_navigate("j")
-- end, {})
-- vim.api.nvim_create_user_command("KittyMoveUp", function()
--   kitty_navigate("k")
-- end, {})
-- vim.api.nvim_create_user_command("KittyMoveRight", function()
--   kitty_navigate("l")
-- end, {})
vim.keymap.set("n", "<C-h>", function()
  kitty_navigate("h")
end, { desc = "", silent = true })
vim.keymap.set("n", "<C-j>", function()
  kitty_navigate("j")
end, { desc = "", silent = true })
vim.keymap.set("n", "<C-k>", function()
  kitty_navigate("k")
end, { desc = "", silent = true })
vim.keymap.set("n", "<C-l>", function()
  kitty_navigate("l")
end, { desc = "", silent = true })
