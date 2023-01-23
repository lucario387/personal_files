---@meta


---@class LSPConfig
vim.g.lsp = {
  --- A list of servers that will have its config called on startup (aside from Java)
  servers = {
    --- List of servers that will use default lspconfig  
    --- Check the list [here](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)
    --- @type string[]
    defaults = {},
    --- List of servers that has changes from the default config,
    --- Check `lua/custom/plugins/lsp/config/custom.lua` for the list of servers
    --- @type string[]
    custom = {},
  },
  --- List of external formatters that will be activate
  --- For example, `prettier`
  --- @type table<string, boolean>
  formatters = {}
}
