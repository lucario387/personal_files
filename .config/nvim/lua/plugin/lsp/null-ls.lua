local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
  return
end

local M = {}

local attach = require("plugin.lsp.utils").on_attach
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local formatting = null_ls.builtins.formatting
-- Null-ls sources
-- To install sources, use mason
local sources = {

  -- Diagnostics
  diagnostics.cppcheck,

  -- Formatting
  formatting.clang_format.with({
    filetypes = { "cs" },
  }),
  formatting.shellharden,
  formatting.autopep8,
  -- formatting.stylua.with({
  --     extra_args = { "--config-path", vim.fn.expand("~/.config/stylua.toml") }
  -- })


  -- Code Actions
  -- code_actions.eslint_d,
  code_actions.shellcheck,
  code_actions.gitsigns,
}



M.setup = function()
  null_ls.setup {
    debug = false,
    sources = sources,
    on_attach = function(client, bufnr)
      attach(client, bufnr)
    end,
  }
end

return M
