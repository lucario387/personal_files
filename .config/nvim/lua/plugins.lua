-- List of all default plugins & their definitions
local plugins = {

  -------------------------------------General---------------------------------
  { "wbthomason/packer.nvim",
    -- cmd = {
    --   "PackerSync",
    --   "PackerCompile",
    --   "PackerLoad",
    --   "PackerStatus",
    -- },
    -- config = function()
    --   require("plugins")
    -- end,
  },
  { "nvim-lua/plenary.nvim", },

  { "lewis6991/impatient.nvim", },

  -- for managing lsp/formatter
  { "williamboman/mason.nvim",
    cmd = "Mason",
    config = function()
      require("mason").setup({
        PATH = "skip",
        ui = {
          border = "rounded",
          icons = {
            package_pending = " ",
            package_installed = " ",
            package_uninstalled = " ﮊ",
          },
        },
        max_concurrent_installers = 4,
      })
    end,
  },

  -------------------------------------Theme-----------------------------------
  { "NvChad/base46",
    module = "base46",
    branch = "dev",
  },

  -------------------------------------LSP-------------------------------------
  { "neovim/nvim-lspconfig", },
  { "glepnir/lspsaga.nvim",
    module = "lspsaga",
    config = function()
      require("lspsaga").setup({
        ui = {
          border = "rounded",
        },
        -- diagnostic = {
        --   keys = {
        --     exec_action = "<CR>",
        --   },
        -- },
        lightbulb = {
          enable = false,
        },
        symbol_in_winbar = {
          enable = false,
        },
      })
    end
  },
  { "jose-elias-alvarez/null-ls.nvim",
    module = "null-ls",
    config = function()
      require("null-ls").setup({
        debug = false,
        on_attach = function(client, bufnr)
          require("mappings").null_ls(bufnr)
        end,
        border = "rounded",
      })
    end,
  },
  -- LSP for specific filetypes
  { "mfussenegger/nvim-jdtls",
    opt = true,
  },
  { "jose-elias-alvarez/typescript.nvim", },
  { "folke/neodev.nvim", opt = true },

  -------------------------------------DAP-------------------------------------
  { "mfussenegger/nvim-dap",
    module = "dap",
    ft = { "c", "cpp" },
    config = function()
      require("config.dap").setup()
    end,
    -- setup = function()
    --   require("core.utils").load_mappings("dap")
    -- end
  },
  { "rcarriga/cmp-dap",
    after = "nvim-dap",
    config = function()
      require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
        sources = {
          { name = "dap" },
        },
      })
    end,
  },
  { "theHamsta/nvim-dap-virtual-text",
    after = "nvim-dap",
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },
  { "rcarriga/nvim-dap-ui",
    after = "nvim-dap",
    config = function()
      require("config.dap.ui")
    end,
  },
  -------------------------------------Tree-sitter-----------------------------
  { "/home/lucario387/.nvchad/config/nvim-treesitter",
    run = ":TSUpdate",
  },
  { "andymass/vim-matchup",
    event = "BufRead",
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        parser_install_dir = vim.fn.stdpath("data") .. "/site",
        matchup = {
          enable = true,
          include_match_words = true,
        },
      })
    end,
  },

  { "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    -- disable = true,
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        parser_install_dir = vim.fn.stdpath("data") .. "/site",
        autotag = {
          enable = true,
        },
      })
    end,
  },
  { "JoosepAlviste/nvim-ts-context-commentstring",
    event = "BufRead",
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        parser_install_dir = vim.fn.stdpath("data") .. "/site",
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
      })
    end,
  },
  { "nvim-treesitter/playground",
    cmd = { "TSPlaygroundToggle", "TSCaptureUnderCursor" },
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        parser_install_dir = vim.fn.stdpath("data") .. "/site",
        playground = {
          enable = true,
          disable = {},
          updatetime = 50,
        },
        query_linter = {
          enable = true,
          use_virtual_text = true,
          lint_events = { "BufRead", "CursorHold" },
        },
      })
    end,
  },
  { "numToStr/Comment.nvim",
    after = "nvim-ts-context-commentstring",
    config = function()
      require("mappings").comment()
      require("Comment").setup({
        mappings = {
          basic = false,
          extra = false,
        },
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },

  -------------------------------------Completion engine-----------------------
  { "rafamadriz/friendly-snippets", },
  { "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
      require("config.cmp")
    end
  },

  { "L3MON4D3/LuaSnip",
    rm_default_opts = true,
    -- disable = true,
    -- after = "nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
      require("luasnip").config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
      })
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.g.luasnippets_path } })

      vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
          if  require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
          and not require("luasnip").session.jump_active
          then
            require("luasnip").unlink_current()
          end
        end,
      })
    end,
  },

  { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
  { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
  { "hrsh7th/cmp-path", after = "nvim-cmp" },

  { "windwp/nvim-autopairs",
    disable = false,
    after = "nvim-cmp",
    -- event = "InsertEnter",
    config = function()
      local autopairs = require("nvim-autopairs")
      -- local Rule = require("nvim-autopairs.rule")
      autopairs.setup({
        fast_wrap = {},
        disable_filetype = { "TelescopePrompt", "vim" },
      })

      require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

      -- autopairs.add_rules({
      --   Rule("%<%>$", "</>", { "typescript", "typescriptreact", "javascript", "javascriptreact" })
      --     :use_regex(true),
      -- })
    end,
  },
  -------------------------------------Telescope-------------------------------
  { "nvim-telescope/telescope.nvim",
    module = "telescope",
    cmd = "Telescope",
    config = function()
      require("config.telescope")
    end,
    setup = function()
      require("mappings").telescope()
    end
  },
  { "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
  },

  -------------------------------------Git-------------------------------------
  { "lewis6991/gitsigns.nvim",
    rm_default_opts = true,
    opt = true,
    config = function()
      loadfile(vim.g.base46_cache .. "git")()
      local null = require("null-ls")

      require("gitsigns").setup({
        signs = {
          add = { text = "┃" },
          change = { text = "┃" },
          delete = { text = "" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        sign_priority = 0,
        max_file_length = 3000,
        preview_config = {
          border = "rounded",
        },
        on_attach = function(bufnr)
          require("mappings").git(bufnr)
        end,
      })
      null.register({
        null.builtins.code_actions.gitsigns,
      })
    end,
    setup = function()
      vim.api.nvim_create_autocmd("BufReadPre", {
        group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
        callback = function()
          vim.fn.system({ "git", "-C", vim.fn.expand("%:p:h"), "rev-parse" })
          if vim.v.shell_error == 0 then
            vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
            -- vim.schedule(function()
            require("packer").loader("gitsigns.nvim")
            -- end)
          end
        end,
      })
    end,
  },
  { "sindrets/diffview.nvim",
    after = "gitsigns.nvim",
    config = function()
      require("diffview").setup({
        enhanced_diff_hl = true,
        view = {
          merge_tool = {
            layout = "diff3_mixed",
            disable_diagnostics = true,
          },
        },
      })
    end,
  },

  -------------------------------------Misc------------------------------------
  { "nvim-tree/nvim-web-devicons", },
  -- tree plugin
  { "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeClose" },
    config = function()
      loadfile(vim.g.base46_cache .. "nvimtree", "b")()
      require("nvim-tree").setup({
        filters = {
          dotfiles = true,
          custom = {
            "node_modules",
            "%.git",
            "%.github",
          },
          exclude = {
            ".gitignore",
            ".gitmodules",
            ".luarc.json",
            ".eslintrc.json",
            ".exrc",
            ".nvim.lua",
            ".editorconfig",
          },
        },
        disable_netrw = true,
        -- hijack_netrw = true,
        ignore_ft_on_setup = { "alpha", "dashboard", "aerial", "mind" },
        sort_by = "extension",
        sync_root_with_cwd = true,
        update_focused_file = {
          enable = true,
          update_cwd = false,
        },
        view = {
          side = vim.g.nvimtree_side,
          width = 25,
          hide_root_folder = false,
          preserve_window_proportions = true,
          mappings = {
            list = {
              { key = "d", action = "trash" },
            },
          },
        },
        git = {
          enable = true,
          show_on_open_dirs = false,
          ignore = false,
          timeout = 5000,
        },
        filesystem_watchers = {
          debounce_delay = 100,
        },
        actions = {
          change_dir = {
            enable = false,
            restrict_above_cwd = true,
            -- global = true,
          },
        },
        renderer = {
          group_empty = true,
          highlight_git = true,
          highlight_opened_files = "name",
          -- root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" },
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
          },
        },
      })
    end,
    setup = function()
      vim.keymap.set("n", "<C-n>", "<Cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
    end,
  },

  { "lukas-reineke/indent-blankline.nvim",
    rm_default_opts = true,
    event = "BufRead",
    config = function()
      pcall(function()
        loadfile(vim.g.base46_cache .. "blankline", "b")()
      end)
      require("indent_blankline").setup({
        filetype_exclude = {
          "help",
          "terminal",
          "packer",
          "qf",
          "lspinfo",
          "mason",
          "TelescopePrompt",
          "TelescopeResults",
          "norg",
          "noice",
        },
        buftype_exclude = {
          "terminal",
          "help",
          "nofile",
        },
        show_trailing_blankline_indent = false,
        show_current_context = true,
        show_first_indent_level = false,
      })
    end,
    -- disable = true
  },

  { "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
      require("colorizer").setup({
        filetypes = {
          "lua",
          "vim",
          "vue",
          "tsx",
          "js",
          "html",
          "css",
          "scss",
          "xml",
          "TelescopeResults",
        }
      })
    end,
  },

  { "MunifTanjim/nui.nvim", },
  { "folke/noice.nvim",
    config = function()
      require("noice").setup({
        cmdline   = { enabled = false },
        messages  = { enabled = false },
        popupmenu = { enabled = false },
        notify    = { enabled = false },
        lsp       = {
          progress = { enabled = false },
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["vim.lsp.util.get_documentation"] = false,
          }
        },
        health    = { checker = false, },
        presets   = { lsp_doc_border = true, }
      })
    end,
  },

  -- load luasnips + cmp related in insert mode only

}

local packer = require("packer")

packer.init({
  auto_clean = true,
  compile_on_sync = true,
  git = { clone_timeout = 6000 },
  display = {
    working_sym = "ﲊ",
    error_sym = "✗ ",
    done_sym = " ",
    removed_sym = " ",
    moved_sym = "",
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
})
packer.startup(function(use)
  for _, plugin in ipairs(plugins) do
    use(plugin)
  end
end)
