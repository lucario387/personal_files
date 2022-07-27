return function(on_attach, capabilities)
  require("lspconfig").bashls.setup({
    on_attach = function(client, bufnr)
      local null = require("null-ls")
      on_attach(client, bufnr)
      require("custom.plugins.lsp").register({
        null.builtins.diagnostics.shellcheck,
        null.builtins.code_actions.shellcheck,
        null.builtins.formatting.shellharden,
        null.builtins.formatting.beautysh
      })
    end,
    capabilities = capabilities,
  })
end
