if vim.g.loaded_custom_lsp then
  return
end
vim.g.loaded_custom_lsp = true
local utils = require("config.lsp")
utils.lsp_handlers()
if not vim.g.lsp or not vim.g.lsp.servers then
  return
end
local on_attach = utils.on_attach
local capabilities = utils.set_capabilities()

if vim.g.lsp.servers.default then
  for _, name in ipairs(vim.g.lsp.servers.default) do
    require("lspconfig")[name].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end
end
if vim.g.lsp.servers.custom then
  for _, name in ipairs(vim.g.lsp.servers.custom) do
    require("config.lsp.config.custom")[name](on_attach, capabilities)
  end
end
