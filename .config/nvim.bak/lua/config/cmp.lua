local present, cmp = pcall(require, "cmp")

if not present or cmp == nil then
	return
end

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.pumheight = 30
local ELLIPSIS_CHAR = "..."
local MAX_LABEL_WIDTH = 40
-- local disabled_filetypes = {
-- 	"terminal",
-- 	"qf",
-- 	"TelescopeResults",
-- 	"TelescopePrompt",
-- 	"lspinfo",
-- 	"packer",
-- 	"stratify",
-- 	"help",
-- }

-- Special case to enable cmp for these two filetypes
-- local dap_filetypes = {
-- 	"dapui_watches",
-- 	"dap-repl",
-- }

local disabled_buftypes = {
	"terminal",
	"nofile",
	"prompt",
}

cmp.setup({
	window = {
		completion = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
			winhighlight = "Normal:Pmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
			side_padding = 0,
		},
		documentation = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
			winhighlight = "Normal:Pmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
		}
	},
	enabled = function()
		local disabled = false
		disabled       = disabled or (vim.tbl_contains(disabled_buftypes, vim.api.nvim_buf_get_option(0, "buftype")))
		disabled       = disabled or (vim.fn.reg_recording() ~= "")
		disabled       = disabled or (vim.fn.reg_executing() ~= "")
		if disabled then return not disabled end

		-- disable completion in comments
		local context = require("cmp.config.context")

		-- keep command mode completion enabled when cursor is in a comment
		if vim.api.nvim_get_mode().mode == "c" then
			return true
		else
			return not context.in_treesitter_capture("comment")
					and not context.in_syntax_group("Comment")
		end
	end,
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	formatting = {
		--fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local icons = require("ui.icons").lspkind
			vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
			local label = vim_item.abbr
			local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
			if truncated_label ~= label then
				vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
			end
			return vim_item
		end,
	},
	mapping = {
		["<C-p>"]     = cmp.mapping.select_prev_item(),
		["<C-n>"]     = cmp.mapping.select_next_item(),
		["<C-f>"]     = cmp.mapping.scroll_docs(4),
		["<C-b>"]     = cmp.mapping.scroll_docs(-4),
		["<C-SPACE>"] = cmp.mapping.complete(),
		["<C-e>"]     = cmp.mapping.close(),
		["<CR>"]      = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Insert,
			select = false,
		},

		["<TAB>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif require("luasnip").expand_or_jumpable() then
				require("luasnip").expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-TAB>"] = cmp.mapping(function(fallback)
			cmp.select_prev_item()
			if cmp.visible() then
			elseif require("luasnip").jumpable(-1) then
				require("luasnip").jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip", keyword_length = 5, },
		{ name = "buffer", keyword_length = 5, },
		{ name = "nvim_lua" },
		{ name = "path", max_item_count = 100 },
	},
})
