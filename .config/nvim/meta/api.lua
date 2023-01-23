---@meta
---@diagnostic disable: codestyle-check

---@param chunks {}
---@param history boolean If true, add to [message-history]()
---@param opts {verbose: boolean}
function vim.api.nvim_echo(chunks, history, opts) end

---@class ApiKeymapOpts
---@field nowait? boolean If true, once the `lhs` is matched, the `rhs` will be executed
---@field expr? boolean Specify whether the `rhs` is an expression to be evaluated or not (default false)
---@field silent? boolean Specify whether `rhs` will be echoed on the command line
---@field unique? boolean Specify whether not to map if there exists a keymap with the same `lhs`
---@field script? boolean
---@field desc? string Description for what the mapping will do
---@field noremap? boolean Specify whether the `rhs` will execute user-defined keymaps if it matches some `lhs` or not
---@field replace_keycodes? boolean Only effective when `expr` is **true**, specify whether to replace keycodes in the resuling string
---@field callback function Lua function to call when the mapping is executed


---For autocommands
---`callback` or `command` has to be defined and they cannot both be defined
---@class ApiCreateAutocmdOpts
---@field group? string|integer autocommand group name or id to match against
---@field pattern? string|string[] pattern(s) to match
---@field buffer? integer buffer number for buffer-local autocommands, **cannot be used with `pattern`**
---@field desc? string description (for documentation/troubleshooting)
---@field callback? string|fun(args: ApiAutocmdCallbackOpts) callback when the event(s) is triggered
---@field command? string Vim command to execute on event(s)
---@field once? boolean Run the command only once
---@field nested? boolean Run nested autocommands

---@class ApiAutocmdCallbackOpts
---@field id integer autocommand id
---@field event Event name of the triggered event
---@field group number|nil autocommand group id
---@field match string expanded value of `<amatch>`
---@field buf integer expanded value of `<abuf>`
---@field file string expanded value of `<afile>`
---@field data any arbitrary data passed from `nvim_exec_autocmds()`

---@class ApiExecAutocmdOpts
---@field group? string|integer [autocmd-groups]() name or id to match against
---@field pattern? string|string[] [autocmd-pattern](). Defaults to `"*"`. Cannot be used with `buffer`
---@field buffer? integer Bufnr. Cannot be used with `pattern`
---@field modeline? boolean Process the modeline after the autocommands
---@field data? any arbitrary data to send to the autocmd callback

---@class ApiClearAutocmdOpts
---@field event Event|Event[]
---@field pattern string|string[] Cannot be used with `buffer`
---@field buffer integer Buffer number to clear the autocmd. Cannot be used with `pattern`
---@field group string|integer The augroup name or id

---Set a global mapping for the given mode
---@param mode VimKeymapMode
---@param lhs string 
---@param rhs string 
---@param opts ApiKeymapOpts|nil
function vim.api.nvim_set_keymap(mode, lhs, rhs, opts) end

---Set a buffer-local mapping for the given mode
---@param buffer integer Buffer handle, or 0 for current buffer
---@param mode VimKeymapMode
---@param lhs string 
---@param rhs string 
---@param opts ApiKeymapOpts|nil
function vim.api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts) end

---@param event Event|Event[] Event(s) that will trigger the handler (either `callback` or `command`)
---@param opts ApiCreateAutocmdOpts Options dict
---@return integer id Id of the autocommand
function vim.api.nvim_create_autocmd(event, opts) end

---Create or get an autocommand group |autocmd-groups|.
---@param name string Name of the group
---@param opts {clear: boolean} clear: Clear existing commands if the group already exists
---@return integer id Id of the created group
---@nodiscard
function vim.api.nvim_create_augroup(name, opts) end

---@param event Event|Event[]
---@param opts ApiExecAutocmdOpts
function vim.api.nvim_exec_autocmds(event, opts) end
