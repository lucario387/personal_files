local M = {}
--- Mappings will be in the format of:
-- mode : {
--  key: {
--    callback : function | string,
--    opts? : table
--  }
--}
-- Learn this mapping style from NvChad/NvChad
-- Shoutout to them :D

local default_mappings = {
	["general"] = {
		n = {
			["j"] = {
				callback = function() require("accelerated-jk").move_to("j") end,
				opts = { silent = true },
			},
			["k"] = {
				callback = function() require("accelerated-jk").move_to("k") end,
				opts = { silent = true },
			},
			["<C-c>"] = {
				callback = "<cmd>%y+<CR>",
				opts = { desc = "Copy buffer", silent = true },
			},
			["<Esc>"] = {
				callback = "<cmd> noh <CR>",
				opts = { desc = "Remove highlight", silent = true },
			},
			["<leader>q"] = {
				callback = "<cmd>q<CR>",
				opts = { desc = "Alt for :q", silent = true },
			},
			-- Movement between splits
			["<C-h>"] = {
				callback = "<C-w>h",
				opts = { desc = "Move to left split", silent = true },
			},
			["<C-l>"] = {
				callback = "<C-w>l",
				opts = { desc = "Move to right split", silent = true },
			},
			["<C-j>"] = {
				callback = "<C-w>j",
				opts = { desc = "Move to split below", silent = true },
			},
			["<C-k>"] = {
				callback = "<C-w>k",
				opts = { desc = "Move to split above", silent = true },
			},
			-- Make it so it's like every other conventional IDE out there
			["<C-s>"] = {
				callback = "<cmd>w<CR>",
				opts = { desc = "Save file", silent = true },
			},
			["<A-j>"] = {
				callback = "<cmd>m+1<CR>==",
				opts = { desc = "Move line down", silent = true },
			},
			["<A-k>"] = {
				callback = "<cmd>m-2<CR>==",
				opts = { desc = "Move line down", silent = true },
			},
			-- NvimTree stuffs
			["<C-n>"] = {
				callback = "<cmd> NvimTreeToggle <CR>",
				opts = { desc = "Toggle NvimTree", silent = true },
			},
			["<leader>e"] = {
				callback = "<cmd> NvimTreeFocus <CR>",
				opts = { desc = "Move focus to NvimTree", silent = true },
			},
			-- Buffers delete
			["<leader>x"] = {
				callback = "<cmd> bp|sp|bn|bd!<CR>",
				opts = { desc = "Close buffer", silent = true, },
			},
			-- Sessions
			["<leader>rs"] = {
				callback = function()
					require("persisted").load()
				end,
				opts = { desc = "Load last session of this folder", silent = true },
			},
			["<leader>ss"] = {
				callback = function()
					require("persisted").save()
				end,
				opts = { desc = "Save Current Session", silent = true },
			},
			-- Comment toggler
			["<leader>/"] = {
				callback = function()
					require("Comment.api").toggle.linewise.current(nil, {})
				end,
				opts = { desc = "Toggle comment on current line", silent = true },
			},
			-- Trouble toggler
			["<leader>aa"] = {
				callback = function()
					require("trouble").toggle()
				end,
				opts = { desc = "Toggle Trouble", silent = true },
			},
			-- Image clipboard
			["<C-A-v>"] = {
				callback = "<cmd>PasteImg<CR>a",
				opts = { desc = "Copy image from clipboard", silent = true },
			},
			--TrueZen
			["<leader>z"] = {
				callback = function()
					vim.cmd("TZMinimalist")
					if(package.loaded["nvim-tree"]) then
						if require("nvim-tree.view").is_visible() then
							require("nvim-tree.view").close()
						end
					end
					vim.opt.showmode = vim.opt.showmode == true and false or true
				end,
				opts = { desc = "Toggle UI", silent = true,}
			},
		},

		i = {
			-- Emacs keybind in insert mode because why not
			-- Esc insert mode
			["jk"] = {
				callback = "<Esc>",
				opts = { desc = "Escape insert mode", silent = true },
			},
			["<C-a>"] = {
				callback = "<Home><C-Right>",
				opts = { desc = "Move to beginning of line", silent = true },
			},
			["<C-e>"] = {
				callback = "<End>",
				opts = { desc = "Move to end of line", silent = true },
			},
			["<C-b>"] = {
				callback = "<C-Left>",
				opts = { desc = "Move back one word", silent = true },
			},
			["<C-f>"] = {
				callback = "<C-Right>",
				opts = { desc = "Move forward one word", silent = true },
			},
			-- Movements
			["<C-h>"] = {
				callback = "<Left>",
				opts = { desc = "Move left", silent = true },
			},
			["<C-l>"] = {
				callback = "<Right>",
				opts = { desc = "Move right", silent = true },
			},
			["<C-j>"] = {
				callback = "<Down>",
				opts = { desc = "Move down", silent = true },
			},
			["<C-k>"] = {
				callback = "<Up>",
				opts = { desc = "Move up", silent = true },
			},
			-- Moving lines
			["<A-j>"] = {
				callback = "<Esc><cmd>m+1<CR>==gi",
				opts = { desc = "Move line down", silent = true },
			},
			["<A-k>"] = {
				callback = "<Esc><cmd>m-2<CR>==gi",
				opts = { desc = "Move line up", silent = true },
			},
			-- Clipboard image
			["<C-A-v>"] = {
				callback = "<Esc><cmd>PasteImg<CR>a",
				opts = { desc = "Copy image from clipboard", silent = true },
			},
		},

		v = {
			["j"] = {
				callback = function() require("accelerated-jk").move_to("j") end,
				opts = { silent = true },
			},
			["k"] = {
				callback = function() require("accelerated-jk").move_to("k") end,
				opts = { silent = true },
			},
			["<C-c>"] = {
				callback = '"+y',
				opts = { desc = "Copy selected text", silent = true },
			},
			["<"] = {
				callback = "<gv",
				opts = { desc = "Move chunk outward without resetting selected area", silent = true },
			},
			[">"] = {
				callback = ">gv",
				opts = { desc = "Move chunk inwards without resetting selected area", silent = true },
			},
			["<leader>/"] = {
				callback = "<Esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
				opts = { desc = "Toggle Comment for selected area", silent = true },
			},
			-- Moving lines
			["<A-j>"] = {
				callback = ":m '>+1<CR>gv=gv",
				opts = { desc = "Move selected lines up", silent = true },
			},
			["<A-k>"] = {
				callback = ":m '<-2<CR>gv=gv",
				opts = { desc = "Move selected lines down", silent = true },
			},
			["p"] = {
				callback = 'p:let @+=@0<CR>:let @"=@0<CR>',
				opts = { silent = true }
			},
		},

		t = {
			["jk"] = {
				callback = "<C-\\><C-n>",
				opts = { desc = "Escape Terminal Mode", silent = true },
			}
		}
	},
	-- It should have prefix as <leader>t so that I can easier memorize
	["telescope"] = {
		n = {
			["<leader>tf"] = {
				callback = "<cmd> Telescope find_files<cr>",
				opts = { desc = "find files", silent = true },
			},
			["<leader>ta"] = {
				callback = "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <cr>",
				opts = { desc = "find all", silent = true },
			},
			["<leader>tw"] = {
				callback = "<cmd> Telescope live_grep <cr>",
				opts = { desc = "find files", silent = true },
			},
			["<leader>tb"] = {
				callback = "<cmd> Telescope buffers <cr>",
				opts = { desc = "find buffers", silent = true },
			},
			["<leader>th"] = {
				callback = "<cmd> Telescope help_tags <cr>",
				opts = { desc = "help page", silent = true },
			},
			["<leader>to"] = {
				callback = "<cmd> Telescope oldfiles<cr>",
				opts = { desc = "find old files", silent = true },
			},
			-- ["<leader>ti"] = {
			--   callback = "<cmd> Telescope media_files<cr>",
			--   opts = { desc = "find media files", silent = true, },
			-- },
			["<leader>tk"] = {
				callback = "<cmd> Telescope keymaps<cr>",
				opts = { desc = "show keymaps", silent = true },
			},
			["<leader>tm"] = {
				callback = [[<cmd>Telescope man_pages sections={"ALL"}<CR>]],
				opts = { desc = "show man page", silent = true },
			},
			-- 	["<leader>cm"] = {
			-- 		callback = "<cmd> Telescope git_commits <cr>",
			-- 		opts = { desc = "git commits", silent = true },
			-- 	},
			-- 	["<leader>gt"] = {
			-- 		callback = "<cmd> Telescope git_status <cr>",
			-- 		opts = { desc = "git status", silent = true },
			-- 	},
			-- 	["<leader>tp"] = {
			-- 		callback = "<cmd> Telescope terms <cr>",
			-- 		opts = { desc = "pick hidden term", silent = true },
			-- 	},
		},
	},
	["dap"] = {
		n = {
			-- following what Vscode do with its debugging hotkeys
			["<F5>"] = {
				callback = function() require("dap").continue() end,
				opts = { desc = "Continue/Start a Debug Session", silent = true },
			},
			["<F17>"] = { --Shift F5 is F17
				callback = function()
					vim.notify("Debug Session Stopped")
					require("dap").terminate()
					require("dap").close()
				end,
				opts = { desc = "Close current debug session", silent = true },
			},
			-- C-S-F5 is not an accepting keymap (unless you modify it) so using C-F5 instead
			["<F29>"] = { -- Ctrl F5 is F29
				callback = function()
					vim.notify("Debug Session Restarting")
					-- print("Test1")
					-- :h dap.terminate()
					require("dap").terminate({}, { terminateDebuggee = true }, function() require("dap").run_last() end)
					-- require("dap").run_last()
				end,
				opts = { desc = "Restart a debug session", silent = true }
			},
			["<F10>"] = {
				callback = function() require("dap").step_over() end,
				opts = { desc = "DAP Step Over", silent = true },
			},
			["<F11>"] = {
				callback = function() require("dap").step_into() end,
				opts = { desc = "DAP Step Over", silent = true },
			},
			["<F23>"] = {
				callback = function() require("dap").step_out() end,
				opts = { desc = "DAP Step Over", silent = true },
			},
			["<leader>b"] = {
				callback = function() require("dap").toggle_breakpoint() end,
				opts = { desc = "Toggle breakpoint on current line", silent = true },
			},
			["<leader>B"] = {
				callback = function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
				opts = { desc = "Set breakpoint on current line", silent = true },
			},
			["<leader>dr"] = {
				callback = function() require("dap").repl.open() end,
				opts = { desc = "Open Debug REPL", silent = true },
			},
			-- ["<leader>dl"] = {
			-- 	callback = function() require("dap").run_last() end,
			-- 	opts = { desc = "Run " }
			-- }
		}
	}
}

for _, mapping in pairs(default_mappings) do
	setkeymaps(mapping)
end

return M
