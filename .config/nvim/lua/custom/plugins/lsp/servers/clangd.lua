return function(on_attach, capabilities)
  require("lspconfig").clangd.setup({
    cmd = {
      "clangd",
      "--background-index",
      "--offset-encoding=utf-16", -- temporary fix to stop null-ls
      "--enable-config",
      "--completion-style=detailed",
      "--clang-tidy",
      "--all-scopes-completion",
      "--pch-storage=memory",
      "--suggest-missing-includes",
    },
    on_attach = function(client, bufnr)
      -- client.server_capabilities.semanticTokensProvider = false
      on_attach(client, bufnr)
    end,
    capabilities = capabilities,
  })
end
