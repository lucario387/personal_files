local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
	return
end


local attach = require("config.lsp.utils").on_attach
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local formatting = null_ls.builtins.formatting
-- Null-ls sources
-- To install sources, use mason
local sources = {
	-- Diagnostics
	diagnostics.cppcheck,
	diagnostics.shellcheck,
	diagnostics.zsh,

	-- Formatting
	formatting.clang_format.with({
		filetypes = { "cs" },
	}),
	formatting.shfmt,
	formatting.shellharden,
	formatting.autopep8,
	formatting.prettierd,
	--formatting.stylua,
	-- Code Actions
	-- code_actions.eslint_d,
	code_actions.shellcheck,
	-- code_actions.gitsigns,
}

null_ls.setup {
	debug = false,
	sources = sources,
	on_attach = function(client, bufnr)
		attach(client, bufnr)
	end,
}
