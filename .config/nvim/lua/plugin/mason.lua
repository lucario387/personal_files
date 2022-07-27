local M = {}

local ensure_installed = {
	"lua-language-server",
	"pyright",

}

M.setup = function()
  require("mason").setup({
    ui = {
      icons = {
        server_installed = " ",
        server_pending = " ",
        -- server_uninstalled = " ﮊ",
      },
    }
  })
	-- vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
end

M.lsp = function()
  require("mason-lspconfig").setup({
    ensure_installed = {
      "sumneko_lua",
      "pyright",
    }
  })
end

return M

