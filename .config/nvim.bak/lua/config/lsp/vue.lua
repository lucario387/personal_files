local M = {}

M.setup = function(attach, capabilities)
	require("lspconfig").volar.setup({
		init_options = {
			typescript = {
				serverPath = vim.fn.getenv("HOME") .. "/.npm-global/lib/node_modules/typescript/lib/tsserverlibrary.js",
			},
		},
		capabilities = capabilities,
		on_attach = attach,
	})
	-- require("lspconfig").eslint.setup({
	-- 	on_attach = function(client, bufnr)
	-- 		-- Load LSP mappings on attach to buffer
	-- 	end,
	-- 	capabilities = capabilities
	-- })
end

return M
