local M = {}

local mappings = {
	n = {
		["gD"] = {
			callback = function()
				vim.lsp.buf.declaration()
			end,
			opts = { buffer = 0, desc = "Lsp declaration", silent = true },
		},
		["gd"] = {
			callback = function()
				vim.lsp.buf.definition({reuse_win = true})
				--require("lspsaga.definition").preview_definition()
			end,
			opts = { buffer = 0, desc = "Lsp definition", silent = true },
		},
		["gr"] = {
			callback = "<cmd>Lspsaga lsp_finder<CR>",
			opts = { buffer = 0, desc = "Open lsp finder", silent = true },
		},
		["K"] = {
			callback = function()
				require("lspsaga.hover").render_hover_doc()
			end,
			opts = { buffer = 0, desc = "Lsp hover", silent = true },
		},
		["gi"] = {
			callback = function() vim.lsp.buf.implementation() end,
			opts = { buffer = 0, desc = "Lsp implementation", silent = true },
		},
		["gs"] = {
			callback = function()
				require("lspsaga.signaturehelp").signature_help()
			end,
			opts = { buffer = 0, desc = "Lsp signature help", silent = true },
		},
		["<leader>D"] = {
			callback = function() vim.lsp.buf.type_definition() end,
			opts = { buffer = 0, desc = "Lsp type definition", silent = true },
		},
		-- ["gr"] = {
		--   callback = function() vim.lsp.buf.references() end,
		--   opts = { buffer = 0, desc = "Lsp references", silent = true },
		-- },
		["<leader>ds"] = {
			callback = function()
				require("lspsaga.diagnostic").show_line_diagnostics()
			end,
			opts = { buffer = 0, desc = "Lsp diagnostic", silent = true, }
		},
		["<leader>fm"] = {
			callback = function() vim.lsp.buf.format({ async = true }) end,
			opts = { buffer = 0, desc = "Lsp Format", silent = true },
		},
		["<leader>rn"] = {
			callback = function()
				require("lspsaga.rename").lsp_rename()
			end,
			opts = { buffer = 0, desc = "Lsp Rename", silent = true },
		},
		["<leader>ca"] = {
			callback = function()
				require("lspsaga.codeaction").code_action()
			end,
			opts = { buffer = 0, desc = "Code Action", silent = true },
		},

		-- LspSaga things
		["<C-d>"] = {
			callback = function()
				require("lspsaga.action").smart_scroll_with_saga(1)
			end,
			opts = { desc = "Scroll the popup window", silent = true },
		},
		["<C-u>"] = {
			callback = function()
				require("lspsaga.action").smart_scroll_with_saga(-1)
			end,
			opts = { desc = "Scroll the popup window", silent = true },
		}
	},
	v = {
		["<leader>ca"] = {
			callback = function()
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
				require("lspsaga.codeaction").range_code_action()
			end,
			opts = { buffer = 0, desc = "Code action", silent = true }
		},
	}
}
local excluded_filetypes = {
	"NvimTree",
	"TelescopePrompt",
	"TelescopeResults",
	"LspInfo",
	"lsp-installer",
}

M.set_mappings = function() setkeymaps(mappings) end

M.on_attach = function(client, bufnr)
	if vim.tbl_contains(excluded_filetypes, vim.bo.filetype) then
		return
	end
	-- vim.api.nvim_buf_set_option()


	-- Load LSP mappings on attach to buffer
	M.set_mappings()
	-- If the LSP server have format provider
	-- Format the file on save
	-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
	-- if client.supports_method("textDocument/formatting") then
	-- 	vim.api.nvim_clear_autocmds({
	-- 		group = augroup,
	-- 		buffer = bufnr,
	-- 	})
	-- 	vim.api.nvim_create_autocmd("BufWritePre", {
	-- 		group = augroup,
	-- 		buffer = bufnr,
	-- 		callback = function()
	-- 			vim.lsp.buf.format({
	-- 				bufnr = bufnr,
	-- 			})
	-- 		end,
	-- 	})
	-- end

	-- Show diagnostics on move
	-- Really wanna enable this but its too distracting
	-- vim.api.nvim_create_autocmd("CursorHold", {
	-- 	buffer = bufnr,
	-- 	callback = function()
	-- 		local opts = {
	-- 			focusable = false,
	-- 			close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
	-- 			border = "rounded",
	-- 			source = "always",
	-- 			prefix = " ",
	-- 			scope = "line",
	-- 		}
	-- 		vim.diagnostic.open_float(opts)
	-- 	end
	-- })
end

M.set_capabilities = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem = {
		documentationFormat = { "markdown", "plaintext" },
		snippetSupport = true,
		preselectSupport = true,
		insertReplaceSupport = true,
		labelDetailsSupport = true,
		deprecatedSupport = true,
		commitCharactersSupport = true,
		tagSupport = { valueSet = { 1 } },
		resolveSupport = {
			properties = {
				"documentation",
				"detail",
				"additionalTextEdits",
			},
		},
	}
	return capabilities
end

M.lsp_handlers = function()

	local function lspSymbol(name, icon)
		local hl = "DiagnosticSign" .. name
		vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
	end

	lspSymbol("Error", " ")
	lspSymbol("Warn", " ")
	lspSymbol("Info", " ")
	lspSymbol("Hint", "")

	vim.diagnostic.config {
		virtual_text     = false,
		signs            = true,
		underline        = true,
		update_in_insert = false,
		severity_sort    = true,
	}

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "single",
		focusable = false,
	})
	-- suppress error messages from lang servers
	vim.notify = function(msg, log_level)
		if msg:match "exit code" then
			return
		end
		if log_level == vim.log.levels.ERROR then
			vim.api.nvim_err_writeln(msg)
		else
			vim.api.nvim_echo({ { msg } }, true, {})
		end
	end
end


return M
