local custom_hls = require("ui.highlights").get_hlgroups()
--local hl_override = require("ui.highlights").get_hlgroups({ "bufferline", "dap", "general" })
palette_colors = require("catppuccin.palettes").get_palette()
require("catppuccin").setup({
	transparent_background = true,
	term_colors = true,
	compile = {
		enabled = true,
		path = vim.fn.stdpath("cache") .. "/catppuccin",
		suffix = "_compiled",
	},
	-- Custom hlgroup
	custom_highlights = custom_hls,
	styles = {
		comments = { "bold", "italic" },
		conditionals = { "bold", "italic" },
		loops = { "bold", "italic" },
		operators = { "bold" },
	},
	integrations = {
		treesitter = true,
		native_lsp = { enabled = true, },
		lsp_trouble = true,
		cmp = true,
		lsp_saga = true,
		gitsigns = true,
		telescope = true,
		nvimtree = {
			enabled = true,
			show_root = true,
			transparent_panel = false,
		},
		indent_blankline = {
			enabled = true,
			colored_indent_levels = false,
		},
		bufferline = false,
		markdown = true,
		dap = {
			enabled = true,
			enabled_ui = true,
		},
		dashboard = false,
		notify = false,
		telekasten = false,
		symbols_outline = false,
		vimwiki = false,
		beacon = false,
	},
	--highlight_overrides = hl_override,
})
vim.cmd("colorscheme catppuccin")
