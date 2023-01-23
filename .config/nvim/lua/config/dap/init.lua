local M = {}

local configs = require("custom.plugins.dap.config")
local adapters = require("custom.plugins.dap.adapters")

M.load_vscode_config = function()
  require("dap.ext.vscode").load_launchjs(nil, {
    cppdbg = { "c", "cpp" },
  })
end

M.setup = function()
  local dap = require("dap")
  local repl = require("dap.repl")
  require("mappings").dap()
  -- nvim-dap settings
  vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
  vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "Error", linehl = "", numhl = "" })
  vim.fn.sign_define("DapStopped", { text = "⭐️", texthl = "" })

  -- dap-repl settings
  repl.commands = vim.tbl_deep_extend("force", repl.commands, {
    exit = { "exit", ".exit", ".bye" },
  })
  for key, value in pairs(adapters) do
    dap.adapters[key] = value
  end
  for name, config in pairs(configs) do
    dap.configurations[name] = config
  end
  vim.api.nvim_create_autocmd("DirChanged", {
    callback = function()
      M.load_vscode_config()
    end,
  })
  vim.api.nvim_create_autocmd("TermOpen", {
    -- group = vim.api.nvim_create_augroup("DapUIConsoleInsert", { clear = true }),
    pattern = "",
    command = "startinsert",
  })
  vim.api.nvim_create_autocmd("TermLeave", {
    pattern = "",
    command = "stopinsert",
  })
  M.load_vscode_config()
end

return M
