local present, packer = pcall(require, "packer")

if not present then
	return
end

packer.init {
	auto_clean = true,
	auto_reload_complied = true,
	compile_on_sync = true,
	disable_commands = true,
	git = { clone_timeout = 6000 },
	-- profile = {
	-- 	enable = true,
	-- 	threshold = 0,
	-- },
	display = {
		working_sym = "ﲊ",
		error_sym = "✗",
		done_sym = "﫟",
		removed_sym = "",
		moved_sym = "",
		open_fn = function()
			return require("packer.util").float { border = "rounded" }
		end,
	},
}

local plugin_list = {
	{ "lewis6991/impatient.nvim", },
	{ "wbthomason/packer.nvim", opt = true, },
	{ "nvim-lua/plenary.nvim" },

	{ "antoinemadec/FixCursorHold.nvim", },
	-- Theme
	{
		"catppuccin/nvim",
		as = "theme",
		run = ":CatppuccinCompile",
		config = function()
			require("ui.catppuccin")
			local flavours = { "latte", "frappe", "macchiato", "mocha" }
			vim.api.nvim_del_user_command("Catppuccin")
			vim.api.nvim_create_user_command(
				"Catppuccin",
				function(inp)
					if not vim.tbl_contains(flavours, inp.args) then
						require("catppuccin.utils.echo")("Invalid flavour", "error")
						return
					end
					vim.g.catppuccin_flavour = inp.args
					reload_theme_auto()
					--vim.defer_fn(function()require("catppuccin").load() end, 0)
				end,
				{
					nargs = 1,
					complete = function(line)
						return vim.tbl_filter(function(val)
							return vim.startswith(val, line)
						end, flavours)
					end,
				}
			)
		end,
	},
	{ "kyazdani42/nvim-web-devicons", after = "theme" },
	-- Statusline
	{
		"feline-nvim/feline.nvim",
		opt = true,
		-- after = "nvim-web-devicons",
		config = function()
			require("ui.feline").setup()
		end,
		setup = function()
			require("lazy_load").statusline()
		end,
	},
	-- Bufferline
	{
		"akinsho/bufferline.nvim",
		opt = true,
		config = function()
			require("ui.bufferline")
		end,
		setup = function()
			require("lazy_load").bufferline()
		end,
	},
	-- tree
	{
		"kyazdani42/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		config = function()
			require("ui.nvimtree")
		end,
	},

	-- Treesitter and its related plugins
	{
		"lukas-reineke/indent-blankline.nvim",
		opt = true,
		-- after = "nvim-treesitter",
		config = function()
			require("config.misc").blankline()
		end,
		setup = function()
			require("lazy_load").blankline()
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufReadPre",
		run = ":TSUpdate",
		config = function()
			require("config.treesitter")
		end,
	},
	{
		"andymass/vim-matchup",
		opt = true,
		setup = function()
			require("lazy_load").matchup()
		end,
	},

	-- LSP time
	-- LSP + DAP + Null-ls Installer
	{
		"williamboman/mason.nvim",
		-- opt = true,
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						server_installed = " ",
						server_pending = " ",
						-- server_uninstalled = " ﮊ",
					},
				}
			})
		end,
		-- setup = function()
		-- 	require("lazy_load").mason()
		-- end,
	},
	-- LSPconfig itself
	{
		"neovim/nvim-lspconfig",
		-- after = "mason.nvim",
		opt = true,
		config = function()
			require("config.lsp")
		end,
		setup = function()
			require("lazy_load").lsp()
		end,
	},
	-- Null-ls
	{
		"jose-elias-alvarez/null-ls.nvim",
		after = "nvim-lspconfig",
		opt = true,
		config = function()
			require("config.lsp.null-ls")
		end,
	},
	-- And other plugins for utilities
	{
		"zbirenbaum/neodim",
		event = "LspAttach",
		config = function()
			require("neodim").setup({
				alpha = 0.75,
				hide = {
					virtual_text = true,
					underline = true,
					signs = false,
				}
			})
		end,
	},
	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		config = function()
			require("config.lsp.lspsaga")
		end,
	},
	{
		"folke/trouble.nvim",
		opt = true,
		module = "trouble",
		config = function()
			require("config.lsp.trouble").setup()
		end,
	},
	-- Addtional functionalities for clangd
	{
		"p00f/clangd_extensions.nvim",
		opt = true,
		ft = { "c", "cpp", "objc", "objcpp" },
		config = function()
			require("config.lsp.clangd").setup()
		end
	},
	-- For java
	{
		"mfussenegger/nvim-jdtls",
		opt = true,
	},


	-- Cmp and its related plugins
	{
		"rafamadriz/friendly-snippets",
		event = "InsertEnter",
	},
	{
		"hrsh7th/nvim-cmp",
		after = "friendly-snippets",
		config = function()
			require("config.cmp")
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		after = "nvim-cmp",
		config = function()
			require("config.misc").luasnip()
		end,
	},
	{ "saadparwaiz1/cmp_luasnip", after = "LuaSnip" },
	{ "hrsh7th/cmp-nvim-lua", after = "LuaSnip", },
	{ "hrsh7th/cmp-nvim-lsp", after = "LuaSnip", },
	{ "hrsh7th/cmp-buffer", after = "LuaSnip", },
	{ "hrsh7th/cmp-path", after = "LuaSnip", },
	{ "windwp/nvim-autopairs", after = "nvim-cmp", config = function() require("config.misc").autopairs() end, },
	--{ "windwp/nvim-ts-autotag", ft = {"vue", "html"} },
	-- Telescope start
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		config = function()
			require("config.telescope")
		end,
		-- setup = function()
		--   require("config.telescope").setkeys()
		-- end,
	},
	{ "nvim-telescope/telescope-fzf-native.nvim", after = "telescope.nvim", run = "make",
		config = function() require("telescope").load_extension("fzf") end, },
	-- Telescope end

	-- DAP and its related plugins
	{
		"mfussenegger/nvim-dap",
		-- opt = true,
		module = "dap",
		config = function()
			require("config.dap").setup()
		end,
		setup = function()
			require("lazy_load").dap()
		end,
	},
	{ "rcarriga/nvim-dap-ui", after = "nvim-dap", config = function() require("config.dap.ui") end },
	{ "theHamsta/nvim-dap-virtual-text", after = "nvim-dap", config = function() require("config.dap.virtual_text") end, },
	-- {
	-- 	"rcarriga/cmp-dap",
	-- 	opt = true,
	-- 	ft = { "dap-repl", "dapui_watches" },
	-- 	after = "nvim-dap",
	-- 	requires = "hrsh7th/nvim-cmp",
	-- },

	-- Misc
	{ "numToStr/Comment.nvim", module = "Comment", keys = { "gc", "gb" },
		config = function() require("config.misc").comment() end, },
	--{ "xiyaowong/accelerated-jk.nvim", config = function() require("accelerated-jk").setup() end, },
	{ "rainbowhxch/accelerated-jk.nvim", },
	{
		"lewis6991/gitsigns.nvim",
		opt = true,
		config = function()
			require("config.misc").gitsigns()
		end,
		setup = function()
			require("lazy_load").gitsigns()
		end,
	},
	-- Clipboard image
	{ "ekickx/clipboard-image.nvim", opt = true, cmd = "PasteImg",
		config = function() require("config.misc").clip_image() end, },

	-- Colorizer
	{
		"NvChad/nvim-colorizer.lua",
		opt = true,
		config = function()
			require("colorizer").setup()
		end,
		setup = function()
			require("lazy_load").colorizer()
		end,
	},

	--TrueZen, looks really helpful
	{
		"Pocco81/true-zen.nvim",
		opt = true,
		cmd = { "TZMinimalist" },
	},

	-- Session management
	{
		"olimorris/persisted.nvim",
		module = "persisted",
		event = "BufReadPre",
		config = function()
			require("config.misc").persisted()
		end
	},
}

packer.startup(function(use)
	for _, plugin in pairs(plugin_list) do
		use(plugin)
	end
end)
