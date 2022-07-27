local M = {}

M.setup = function(attach, capabilities)
	--local lspconfig = require("lspconfig")
	require("lspconfig").tsserver.setup({
		init_options = {
			hostInfo = "neovim",
			-- includeInlayParameterNameHints = "all",
		},
		on_attach = attach,
		capabilities = capabilities,
	})

	-- lspconfig.eslint.setup({
	-- 	on_attach = function(client, bufnr)
	-- 		-- Load LSP mappings on attach to buffer
	-- 		require("config.lsp.utils").set_mappings()
	-- 	end,
	-- 	capabilities = capabilities
	-- })
end

return M
