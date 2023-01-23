local dap, dapui = require("dap"), require("dapui")
dapui.setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = false,
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    -- {
    --   elements = {
    --     -- Elements can be strings or table with id and size keys.
    --     { id = "scopes", size = 0.25 },
    --     "breakpoints",
    --     "stacks",
    --     "watches",
    --   },
    --   size = 40, -- 40 columns
    --   position = "left",
    -- },
    {
      elements = {
        -- "console",
        "repl",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "rounded", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
  },
})

dap.listeners.before.event_initialized["dapui_config"] = function()
  if packer_plugins["nvim-tree.lua"] and packer_plugins["nvim-tree.lua"].loaded then
    vim.api.nvim_command("silent! NvimTreeClose")
  end
  for _, winnr in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local bufnr = vim.api.nvim_win_get_buf(winnr)
    if vim.api.nvim_buf_get_option(bufnr, "ft") == "dap-repl" then
      return
    end
  end
  dapui:open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  vim.cmd("stopinsert")
  -- dapui:close()
end
dap.listeners.after.event_exited["dapui_config"] = function()
  vim.cmd("stopinsert")
  -- dapui:close()
end
