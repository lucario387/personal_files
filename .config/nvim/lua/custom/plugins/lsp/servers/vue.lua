return function(on_attach, capabilities)
  require("lspconfig").volar.setup({
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      -- require("custom.plugins.lsp.utils").on_attach(client, bufnr)
      -- vim.keymap.set("n", "<leader>fm", function()
      --   vim.cmd("EslintFixAll")
      -- end, { buffer = 0, silent = true })
    end,
    capabilities = capabilities
  })
end
