-- local sumneko_binary = vim.fn.expand("~/.local/share/nvim/mason/bin/lua-language-server")
local M = {}

M.setup = function(attach, capabilities)
  require("lspconfig").sumneko_lua.setup {
    -- cmd = { sumneko_binary },
    on_attach = attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = { "vim" },
          neededFileStatus = {
            -- ["trailing-space"] = "None",
            ["type-check"] = "Opened",
            ["codestyle-check"] = "Opened",
          },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        format = {
          enable = true,
          defaultConfig = {
            indent_style = "space",
            tab_width = "2",
            indent_size = "2",
            quote_style = "double",
            align_call_args = "true",
            align_function_define_params = "true",
            continuous_assign_statement_align_to_equal_sign = "true",
            continuous_assign_table_field_align_to_equal_sign = "true",
            keep_one_space_between_table_and_braket = "true",
            keep_one_space_between_namedef_and_attribute = "true",
            -- Diagnostics
            insert_final_newline = "true",
            -- Namestyle checks
          },
        },
        hint = {
          enable = true,
        },
        hover = {
          enable = true,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }
end

return M
