return function(on_attach, capabilities)
  require("lspconfig").pyright.setup({
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      require("custom.plugins.lsp").register({
        require("null-ls").builtins.formatting.autopep8
      })
    end,
    capabilities = capabilities,
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic",
        }
      }
    }
  })
end
