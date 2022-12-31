return function(on_attach, capabilities)
  local lspconfig = require("lspconfig")
  lspconfig.jsonls.setup({
    on_attach = function(client, bufnr)
      client.server_capabilities.formattingProvider = false
      client.server_capabilities.rangeFormattingProvider = false
      on_attach(client, bufnr)
    end,
    capabilities = capabilities
  })
  if not vim.g.loaded_clangd_ext then
    lspconfig.clangd.setup({
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
  else
    require("clangd_extensions").setup({
      server = {
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
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
          debounce_text_changes = 150,
          allow_incremental_sync = true,
        },
      },
      extensions = {
        autoSetHints = false,
        ast = {
          role_icons = {
            type = "",
            declaration = "",
            expression = "",
            specifier = "",
            statement = "",
            ["template argument"] = "",
          },
        },
        memory_usage = {
          border = "rounded",
        },
        symbol_info = {
          border = "rounded",
        }
      }
    })
  end
  lspconfig.eslint.setup({
    on_attach = function(client, bufnr)
      client.server_capabilities.definitionProvider = false
      client.server_capabilities.completionProvider = false
      client.server_capabilities.signatureHelpProvider = false
      client.server_capabilities.declarationProvider = false
      client.server_capabilities.implementationProvider = false
      client.server_capabilities.typeDefinitionProvider = false
      client.server_capabilities.referencesProvider = false
      client.server_capabilities.inlayHintProvider = false
      if vim.g.lsp_use_tsserver_formatting then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      else
        if vim.g.lsp_use_prettier then
          require("custom.plugins.lsp").register({
            require("null-ls").builtins.formatting.prettierd
          })
        end
      end
      on_attach(client, bufnr)
      -- vim.keymap.set("n", "<leader>fm", function()
      --   vim.cmd("EslintFixAll")
      -- end, { buffer = 0, silent = true })
    end,
    capabilties = capabilities,
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
  if vim.g.lsp_use_tsserver then
    vim.cmd.packadd("typescript.nvim")
    require("typescript").setup({
      server = {
        on_attach = function(client, bufnr)
          if not vim.g.lsp_use_tsserver_formatting then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end
          on_attach(client, bufnr)
        end,
        capabilities = capabilities,
        single_file_support = true,
      }
    })
  else
    lspconfig.volar.setup({
      filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        -- require("custom.plugins.lsp.utils").on_attach(client, bufnr)
        -- vim.keymap.set("n", "<leader>fm", function()
        --   vim.cmd("EslintFixAll")
        -- end, { buffer = 0, silent = true })
      end,
      capabilities = capabilities,
    })
  end
  lspconfig.sumneko_lua.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        telemetry = {
          enable = false,
        },
        workspace = {
          checkThirdParty = false,
        },
      }
    }
  })
  if vim.g.lsp_use_pylance then
    require("custom.plugins.lsp.servers.pylance")
    lspconfig.pylance.setup({})
  else
    lspconfig.pyright.setup({
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
  require("lspconfig").bashls.setup({
    on_attach = function(client, bufnr)
      local null = require("null-ls")
      on_attach(client, bufnr)
      require("custom.plugins.lsp").register({
        null.builtins.diagnostics.shellcheck,
        null.builtins.code_actions.shellcheck,
        null.builtins.formatting.shellharden,
        -- null.builtins.formatting.beautysh
      })
    end,
    capabilities = capabilities,
  })
end
