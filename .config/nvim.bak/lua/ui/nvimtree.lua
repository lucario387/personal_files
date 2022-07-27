local present, nvimtree = pcall(require, "nvim-tree")
if not present then
	return
end

local default = {
	create_in_closed_folder = true,
	filters = {
		dotfiles = false,
		custom = {
			"node_modules",
			".git",
			".github",
			-- "^plugin/*_compiled.*",
		},
		exclude = {
			".gitignore",
		}
	},
	disable_netrw = true,
	hijack_netrw = true,
	ignore_ft_on_setup = { "alpha", "dashboard", "aerial" },
	open_on_setup = false,
	open_on_setup_file = false,
	open_on_tab = false,
	sort_by = "extension",
	hijack_cursor = false,
	hijack_unnamed_buffer_when_opening = false,
	update_cwd = true,
	update_focused_file = {
		enable = true,
		update_cwd = false,
	},
	view = {
		side = "left",
		-- adaptive_size = true,
		-- centralize_selection = true,
		width = 25,
		hide_root_folder = false,
		preserve_window_proportions = false,
		signcolumn = "yes",
	},
	git = {
		enable = true,
		ignore = false,
		timeout = 500,
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		debounce_delay = 200,
		icons = {
			hint = " ",
			error = " ",
			info = " ",
			warning = " ",
		},
	},
	filesystem_watchers = {
		enable = true,
		debounce_delay = 100,
	},
	actions = {
		open_file = {
			resize_window = false,
		},
		change_dir = {
			restrict_above_cwd = true,
			-- global = true,
		}
	},
	renderer = {
		group_empty = true,
		highlight_git = false,
		highlight_opened_files = "all",
		root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" },
		indent_markers = {
			enable = true,
		},
		icons = {
			show = {
				file = true,
				folder = true,
				folder_arrow = false,
				git = true,
			},
			padding = "",
			glyphs = {
				default = "",
				symlink = "",
				git = {
					deleted = "",
					ignored = "◌",
					renamed = "➜",
					staged = "✓",
					unmerged = "",
					unstaged = "✗",
					untracked = "★",
				},
				folder = {
					default = "",
					empty = "",
					empty_open = "",
					open = "",
					symlink = "",
					symlink_open = "",
					arrow_open = "",
					arrow_closed = "",
				},
			}
		},
		special_files = {
			"Cargo.toml", "Makefile", "README.md", "readme.md", "OMakefile",
		}
	},
}

nvimtree.setup(default)
