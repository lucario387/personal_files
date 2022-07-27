local M = {}
--- Mappings will be in the format of:
-- mode : {
--  key: {
--    callback : function | string,
--    opts? : table
--  }
--}
local default_mappings = {
	n = {
		["<C-c>"] = {
			callback = "<cmd>%y+<CR>",
			opts = { desc = "Copy buffer", noremap = true, silent = true },
		},
		["<Esc>"] = {
			callback = "<cmd> noh <CR>",
			opts = { desc = "Remove highlight", noremap = true, silent = true },
		},
		["<leader>q"] = {
			callback = "<cmd>q<CR>",
			opts = { desc = "Alt for :q", noremap = true, silent = true },
		},
		-- Movement between splits
		["<C-h>"] = {
			callback = "<C-w>h",
			opts = { desc = "Move to left split", noremap = true, silent = true },
		},

		["<C-l>"] = {
			callback = "<C-w>l",
			opts = { desc = "Move to right split", noremap = true, silent = true },
		},
		["<C-j>"] = {
			callback = "<C-w>j",
			opts = { desc = "Move to split below", noremap = true, silent = true },
		},
		["<C-k>"] = {
			callback = "<C-w>k",
			opts = { desc = "Move to split above", noremap = true, silent = true },
		},
		-- Make it so it's like every other conventional IDE out there
		["<C-s>"] = {
			callback = "<cmd>w<CR>",
			opts = { desc = "Save file", noremap = true, silent = true },
		},
		["<A-j>"] = {
			callback = "<cmd>m+1<CR>==",
			opts = { desc = "Move line down", noremap = true, silent = true },
		},
		["<A-k>"] = {
			callback = "<cmd>m-2<CR>==",
			opts = { desc = "Move line down", noremap = true, silent = true },
		},
		-- NvimTree stuffs
		["<C-n>"] = {
			callback = "<cmd> NvimTreeToggle <CR>",
			opts = { desc = "Toggle NvimTree", noremap = true, silent = true },
		},
		["<leader>e"] = {
			callback = "<cmd> NvimTreeFocus <CR>",
			opts = { desc = "Move focus to NvimTree", noremap = true, silent = true },
		},
		-- Buffers delete
		["<leader>x"] = {
			callback = "<cmd> bp|sp|bn|bd!<CR>",
			opts = { desc = "Close buffer", noremap = true, silent = true, },
		},
		-- Sessions
		["<leader>rs"] = {
			callback = function()
				require("persisted").load()
			end,
			opts = { desc = "Load last session of this folder", noremap = true, silent = true },
		},
		-- Comment toggler
		["<leader>/"] = {
			callback = function()
				require("Comment.api").toggle_current_linewise()
			end,
			opts = { desc = "Toggle comment on current line", noremap = true, silent = true },
		},
		-- Trouble toggler
		["<leader>aa"] = {
			callback = function()
				require("trouble").toggle()
			end,
			opts = { desc = "Toggle Trouble", noremap = true, silent = true },
		},
		-- Image clipboard
		["<C-A-v>"] = {
			callback = "<cmd>PasteImg<CR>a",
			opts = { desc = "Copy image from clipboard", noremap = true, silent = true },
		},
	},
	i = {
		-- Esc insert mode
		["jk"] = {
			callback = "<Esc>",
			opts = { desc = "Escape insert mode", noremap = true, silent = true },
		},
		-- Movements
		["<C-h>"] = {
			callback = "<Left>",
			opts = { desc = "Move left", noremap = true, silent = true },
		},
		["<C-l>"] = {
			callback = "<Right>",
			opts = { desc = "Move right", noremap = true, silent = true },
		},
		["<C-j>"] = {
			callback = "<Down>",
			opts = { desc = "Move down", noremap = true, silent = true },
		},
		["<C-k>"] = {
			callback = "<Up>",
			opts = { desc = "Move up", noremap = true, silent = true },
		},
		["<C-b>"] = {
			callback = "<Esc>^i",
			opts = { desc = "Move to beginning of line", noremap = true, silent = true },
		},
		["<C-e>"] = {
			callback = "<End>",
			opts = { desc = "Move to end of line", noremap = true, silent = true },
		},
		-- Moving lines
		["<A-j>"] = {
			callback = "<Esc><cmd>m+1<CR>==gi",
			opts = { desc = "Move line down", noremap = true, silent = true },
		},
		["<A-k>"] = {
			callback = "<Esc><cmd>m-2<CR>==gi",
			opts = { desc = "Move line up", noremap = true, silent = true },
		},
		-- Clipboard image
		["<C-A-v>"] = {
			callback = "<Esc><cmd>PasteImg<CR>a",
			opts = { desc = "Copy image from clipboard", noremap = true, silent = true },
		},
	},

	v = {
		["<C-c>"] = {
			callback = '"+y',
			opts = { desc = "Copy selected text", noremap = true, silent = true },
		},
		["<"] = {
			callback = "<gv",
			opts = { desc = "Move chunk outward without resetting selected area", noremap = true, silent = true },
		},
		[">"] = {
			callback = ">gv",
			opts = { desc = "Move chunk inwards without resetting selected area", noremap = true, silent = true },
		},
		["<leader>/"] = {
			callback = "<Esc><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>",
			opts = { desc = "Toggle Comment for selected area", noremap = true, silent = true },
		},
		-- Moving lines
		["<A-j>"] = {
			callback = ":m '>+1<CR>gv=gv",
			opts = { desc = "Move selected lines up", noremap = true, silent = true },
		},
		["<A-k>"] = {
			callback = ":m '<-2<CR>gv=gv",
			opts = { desc = "Move selected lines down", noremap = true, silent = true },
		},
	}
}

local telescope = {
	n = {
		["<leader>ff"] = {
			callback = "<cmd> Telescope find_files<cr>",
			opts = { desc = "find files", noremap = true, silent = true },
		},
		["<leader>fa"] = {
			callback = "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <cr>",
			opts = { desc = "find all", noremap = true, silent = true },
		},
		["<leader>fw"] = {
			callback = "<cmd> Telescope live_grep <cr>",
			opts = { desc = "find files", noremap = true, silent = true },
		},
		["<leader>fb"] = {
			callback = "<cmd> Telescope buffers <cr>",
			opts = { desc = "find buffers", noremap = true, silent = true },
		},
		["<leader>fh"] = {
			callback = "<cmd> Telescope help_tags <cr>",
			opts = { desc = "help page", noremap = true, silent = true },
		},
		["<leader>fo"] = {
			callback = "<cmd> Telescope oldfiles<cr>",
			opts = { desc = "find old files", noremap = true, silent = true },
		},
		-- ["<leader>fi"] = {
		--   callback = "<cmd> Telescope media_files<cr>",
		--   opts = { desc = "find media files", noremap = true, silent = true, },
		-- },
		["<leader>tk"] = {
			callback = "<cmd> Telescope keymaps<cr>",
			opts = { desc = "show keymaps", noremap = true, silent = true },
		},
		["<leader>tm"] = {
			callback = "<cmd> Telescope man_pages sections={\"all\"}<cr>",
			opts = { desc = "show man page", noremap = true, silent = true },
		},
		["<leader>cm"] = {
			callback = "<cmd> Telescope git_commits <cr>",
			opts = { desc = "git commits", noremap = true, silent = true },
		},
		["<leader>gt"] = {
			callback = "<cmd> Telescope git_status <cr>",
			opts = { desc = "git status", noremap = true, silent = true },
		},
		["<leader>pt"] = {
			callback = "<cmd> Telescope terms <cr>",
			opts = { desc = "pick hidden term", noremap = true, silent = true },
		},
	},
}

M.setkeymaps = function(mappings)
	for mode, maps in pairs(mappings) do
		for lhs, opt in pairs(maps) do
			vim.keymap.set(mode, lhs, opt.callback, opt.opts)
		end
	end
end

M.setup = function()
	M.setkeymaps(default_mappings)
	M.setkeymaps(telescope)
end

return M
