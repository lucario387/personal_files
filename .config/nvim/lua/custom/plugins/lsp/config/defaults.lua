return function(on_attach, capabilities)
  local servers = {
    "html",
    "cssls",
    -- "jedi_language_server",
    -- "ruff_lsp",
    -- "cssmodules_ls",
  }
  for _, name in pairs(servers) do
    require("lspconfig")[name].setup({
      on_attach = function(client, bufnr)
        client.server_capabilities.formattingProvider = false
        client.server_capabilities.rangeFormattingProvider = false
        on_attach(client, bufnr)
      end,
      capabilities = capabilities,
    })
  end
end
