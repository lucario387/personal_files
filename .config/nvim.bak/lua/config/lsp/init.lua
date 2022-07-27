local lspconfig = require("lspconfig")

local lsp_utils = require("config.lsp.utils")
local attach = lsp_utils.on_attach
-- Capabilities
local capabilities = lsp_utils.set_capabilities()

lsp_utils.lsp_handlers()

-- lspservers with default config
local default_servers = {
	"html", "cssls",
	"bashls",
	"ocamllsp",
	"volar",
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

-- custom config servers, each has its own file for maintaining it
local custom_servers = { "lua", "python", "js" }
for _, lsp in pairs(custom_servers) do
	local mod = "config.lsp." .. lsp
	require(mod).setup(attach, capabilities)
end
