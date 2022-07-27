local M = {}

M.setup = function(attach, capabilities)
  require("lspconfig").pyright.setup({
    on_attach = attach,
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

return M
