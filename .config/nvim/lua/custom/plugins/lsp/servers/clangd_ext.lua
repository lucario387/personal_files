return function(on_attach, capabilities)
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
      -- function(client, bufnr)
      --   -- client.server_capabilities.inlayHintsProvider = false
      --   require("core.utils").load_mappings("lspconfig", { buffer = bufnr })
      --   -- register({
      --   --   null.builtins.diagnostics.cppcheck
      --   -- })
      -- end,
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

        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        }
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
