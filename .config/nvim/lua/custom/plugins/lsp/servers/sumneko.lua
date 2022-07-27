return function(on_attach, capabilities)
  -- local present, neodev = pcall(require, "neodev")
  -- if present then
  --   neodev.setup()
  -- end

  require("lspconfig").sumneko_lua.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        telemetry = {
          enable = false,
        }
      }
    }
  })
end
