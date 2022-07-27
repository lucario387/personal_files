return function(on_attach, capabilties)
  require("lspconfig").eslint.setup({
    on_attach = function(client, bufnr)
      client.server_capabilities.definitionProvider = false
      client.server_capabilities.completionProvider = false
      client.server_capabilities.signatureHelpProvider = false
      client.server_capabilities.declarationProvider = false
      client.server_capabilities.implementationProvider = false
      client.server_capabilities.typeDefinitionProvider = false
      client.server_capabilities.referencesProvider = false
      client.server_capabilities.inlayHintProvider = false
      require("custom.plugins.lsp").register({
        require("null-ls").builtins.formatting.prettierd
      })
      on_attach(client, bufnr)
      -- vim.keymap.set("n", "<leader>fm", function()
      --   vim.cmd("EslintFixAll")
      -- end, { buffer = 0, silent = true })
    end,
    capabilties = capabilties,
    settings = {
      codeAction = {
        disableRuleComment = {
          enable = true,
          location = "separateLine"
        },
        showDocumentation = { enable = true }
      },
      codeActionOnSave = {
        enable = true,
        mode = "problems"
      },
      format = true,
      nodePath = "",
      onIgnoredFiles = "off",
      packageManager = "npm",
      quiet = false,
      rulesCustomizations = {},
      problems = {
        shortenToSingleFile = true,
      },
      run = "onSave",
      useESLintClass = true,
      validate = "on",
      workingDirectory = {
        mode = "location"
      }
    }
  })
end
