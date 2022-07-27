local options = {
	border_style = "rounded",
	move_in_saga = { prev = "<C-p>", next = "<C-n>" },
	diagnostic_header = { " ", " ", " ", "ﯧ " },
	show_diagnostic_source = true,
	max_preview_lines = 200,
	rename_action_quit = "<C-c>",
	rename_in_select = true,
	symbol_in_winbar = {
		in_custom = false,
		enable = false,
		separator = "  ",
		show_file = true,
		click_support = false,
	},
}

require("lspsaga").init_lsp_saga(options)
