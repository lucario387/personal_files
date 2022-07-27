local M = {}

M.setup = function()
  local lsp_utils = require("plugin.lsp.utils")
  local attach = lsp_utils.on_attach
  local capabilities = lsp_utils.set_capabilities()
  capabilities.offsetEncoding = "utf-16"
  require("clangd_extensions").setup({
    server = {
      cmd = {
        "clangd",
        "--offset-encoding=utf-16", -- temporary fix to stop null-ls
        "--enable-config",
        "--completion-style=detailed",
        "--clang-tidy",
        "--all-scopes-completion",
        "--pch-storage=memory",
        "--suggest-missing-includes",
      },
      on_attach = attach,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150,
      },
    },
    extensions = {
      autosetHint = true,
      inlay_hints = {
        highlight = "DiagnosticInfo",
      },
      ast = {
        type = "",
      },
    }
  })
end

return M
