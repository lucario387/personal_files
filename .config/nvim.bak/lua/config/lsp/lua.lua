-- local sumneko_binary = vim.fn.expand("~/.local/share/nvim/mason/bin/lua-language-server")
local M = {}


M.setup = function(attach, capabilities)
	require("lspconfig").sumneko_lua.setup {
		-- cmd = { sumneko_binary },
		on_attach = attach,
		capabilities = capabilities,
		settings = {
			-- All settings have been moved to .luarc.json
			-- So that configuring other lua files no longer have vim globals
			Lua = {
				telemetry = {
					enable = false,
				},
				-- format = {
				-- 	enable = true,
				-- },
			},
		},
	}
end


return M
