---@type CustomLSPConfig
local M = {}

M.jsonls = function(on_attach, capabilities)
  require("lspconfig").jsonls.setup({
    on_attach = function(client, bufnr)
      client.server_capabilities.formattingProvider = false
      client.server_capabilities.rangeFormattingProvider = false
      on_attach(client, bufnr)
    end,
    capabilities = capabilities,
  })
end

M.neodev = function(on_attach, capabilities)
  vim.cmd.packadd("neodev.nvim")
  require("neodev").setup({
    library = {
      plugins = false,
    }
  })
  require("lspconfig").sumneko_lua.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        telemetry = {
          enable = false,
        },
        completion = {
          callSnippet = "Both",
        },
        format = {
          defaultConfig = {
            align_call_args = false,
            align_function_define_params = true,
            continuation_indent_size = 2,
            continuous_assign_statement_align_to_equal_sign = true,
            continuous_assign_table_field_align_to_equal_sign = true,
            if_condition_align_with_each_other = true,
            if_condition_no_continuation_indent = true,
            indent_size = 2,
            indent_style = "space",
            insert_final_newline = true,
            keep_one_space_between_namedef_and_attribute = true,
            keep_one_space_between_table_and_braket = true,
            label_no_indent = true,
            quote_style = "double",
          }
        }
      }
    }
  })
end

M.sumneko_lua = function(on_attach, capabilities)
  require("lspconfig").sumneko_lua.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      Lua = {
        telemetry = {
          enable = false,
        },
        workspace = {
          checkThirdParty = false,
          library = {
            "/usr/local/share/nvim/runtime",
            "/home/lucario387/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
            "/home/lucario387/.local/share/nvim/site/pack/packer/opt/lspsaga.nvim",
            "/home/lucario387/.local/share/nvim/site/pack/packer/opt/nvim-cmp",
            "/home/lucario387/.config/nvim/meta"
          },
          ignoreSubmodules = true,
        },
        runtime = {
          version = "LuaJIT",
          path = {
            "lua/?.lua",
            "lua/?/init.lua",
          },
          pathStrict = true,
        },
        diagnostics = {
          libraryFiles = "Disable",
          globals = {
            "vim",
          }
        },
        hover = {
          expandAlias = false,
        },
        completion = {
          callSnippet = "Both",
        },
        format = {
          defaultConfig = {
            align_call_args = false,
            align_function_define_params = true,
      			continuation_indent_size = 2,
      			continuous_assign_statement_align_to_equal_sign = true,
      			continuous_assign_table_field_align_to_equal_sign = true,
      			if_condition_align_with_each_other = true,
      			if_condition_no_continuation_indent = true,
      			indent_size = 2,
      			indent_style = "space",
      			insert_final_newline = true,
      			keep_one_space_between_namedef_and_attribute = true,
      			keep_one_space_between_table_and_braket = true,
      			label_no_indent = true,
      			quote_style = "double",
          }
        }
      }
    }
  })
end

M.clangd = function(on_attach, capabilities)
  if not vim.g.loaded_clangd_ext then
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
        },
      },
    })
  end
end

M.eslint = function(on_attach, capabilities)
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
      if vim.g.lsp.formatters and vim.g.lsp.formatters["tsserver"] then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      else
        require("config.lsp").register({
          require("null-ls").builtins.formatting.prettierd,
        })
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
          location = "separateLine",
        },
        showDocumentation = { enable = true },
      },
      codeActionOnSave = {
        enable = true,
        mode = "problems",
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
        mode = "location",
      },
    },
  })
end

M.tsserver = function(on_attach, capabilities)
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
    },
  })
end

M.volar = function(on_attach, capabilities)
  require("lspconfig").volar.setup({
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      on_attach(client, bufnr)
      -- require("config.lsp.utils").on_attach(client, bufnr)
      -- vim.keymap.set("n", "<leader>fm", function()
      --   vim.cmd("EslintFixAll")
      -- end, { buffer = 0, silent = true })
    end,
    capabilities = capabilities,
  })
end

M.pyright = function(on_attach, capabilities)
  require("lspconfig").pyright.setup({
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      require("config.lsp").register({
        require("null-ls").builtins.formatting.autopep8,
      })
    end,
    capabilities = capabilities,
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic",
        },
      },
    },
  })
end

M.pylance = function(on_attach, capabilities)
  require("config.lsp.servers.pylance")
  require("lspconfig").pylance.setup({})
end

M.bashls = function(on_attach, capabilities)
  require("lspconfig").bashls.setup({
    on_attach = function(client, bufnr)
      local null = require("null-ls")
      on_attach(client, bufnr)
      require("config.lsp").register({
        null.builtins.diagnostics.shellcheck,
        null.builtins.code_actions.shellcheck,
        null.builtins.formatting.shellharden,
        -- null.builtins.formatting.beautysh
      })
    end,
    capabilities = capabilities,
  })
end

return M
