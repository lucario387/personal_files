return function(on_attach, capabilities)
  require("lspconfig").jsonls.setup({
    on_attach = function(client, bufnr)
      client.server_capabilities.formattingProvider = false
      client.server_capabilities.rangeFormattingProvider = false
      on_attach(client, bufnr)
    end,
    capabilities = capabilities
  })
end
