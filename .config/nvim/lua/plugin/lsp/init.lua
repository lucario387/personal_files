local M = {}


M.config = function(lspconfig)
  local lsp_utils = require("plugin.lsp.utils")
  local attach = lsp_utils.on_attach
  -- Capabilities
  local capabilities = lsp_utils.set_capabilities()

  lsp_utils.lsp_handlers()

  -- lspservers with default config
  local default_servers = {
    "html", "cssls",
    "bashls",
    "ocamllsp",
  }
  for _, lsp in ipairs(default_servers) do
    lspconfig[lsp].setup({
      capabilities = capabilities,
      on_attach = attach,
      flags = {
        debounce_text_changes = 150,
      },
    })
  end

  local custom_servers = { "lua", "python", "js" }
  for _, lsp in pairs(custom_servers) do
    local mod = "plugin.lsp." .. lsp
    require(mod).setup(attach, capabilities)
  end

end

M.setup = function()
  -- Basic settings
  local present, lspconfig = pcall(require, "lspconfig")
  if not present then
    return
  end
  M.config(lspconfig)
end

return M
