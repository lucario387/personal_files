---@meta
---@diagnostic disable: codestyle-check

-- vim.keymap = require("vim.keymap")

---@class VimKeymapSetOpts : ApiKeymapOpts
---@field remap? boolean inverse of `noremap`
---@field buffer? integer|boolean|nil Specify the buffer that the keymap will be effective in. If 0 or true, the current buffer will be used

---@param mode VimKeymapMode|VimKeymapMode[] Mode shortnames similar to [nvim_set_keymap()]
---@param lhs string sequence of key to trigger
---@param rhs string|function What the sequence of key in lhs will do
---@param opts? VimKeymapSetOpts
vim.keymap.set = function(mode, lhs, rhs, opts) end

---@param mode VimKeymapMode|VimKeymapMode[] Mode shortnames as [nvim_set_keymap()]
---@param lhs string sequence of keymap with lhs to remove
---@param opts {buffer: boolean}|nil To delete the keymap only for which buffer 
vim.keymap.del = function(mode, lhs, opts) end

-- vim.treesitter = require("vim.treesitter")
-- vim.treesitter.query = require("vim.treesitter.query")

-- vim.lsp = require("vim.lsp")
