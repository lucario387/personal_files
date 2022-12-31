return {
  --------------Removed plugins-----------------------------
  ["folke/which-key.nvim"] = false,
  ["goolord/alpha-nvim"] = false,
  ["NvChad/nvterm"] = false,
  ["NvChad/ui"] = false,
  ["hrsh7th/cmp-nvim-lua"] = false,
  ["kyazdani42/nvim-tree.lua"] = false,
  ["kyazdani42/nvim-web-devicons"] = false,
  ["nvim-treesitter/nvim-treesitter"] = false,
  -- ["windwp/nvim-autopairs"] = false,
  ----------------------------------------------------------
  --------------Plugins not in NvChad-----------------------
  -- General
  -- Treesitter related stuffs
  ["andymass/vim-matchup"] = {
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
    end
  },

  ["windwp/nvim-ts-autotag"] = {
    event = "InsertEnter",
    -- disable = true,
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        parser_install_dir = vim.fn.stdpath("data") .. "/site",
        autotag = {
          enable = true,
        }
      })
    end
  },
  ["JoosepAlviste/nvim-ts-context-commentstring"] = {
    event = "BufRead",
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        parser_install_dir = vim.fn.stdpath("data") .. "/site",
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        }
      })
    end
  },
  ["nvim-treesitter/playground"] = {
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
          lint_events = { "BufRead", "CursorHold", },
        },
      })
    end
  },
  -- ["kylechui/nvim-surround"] = {
  --   event = "BufRead",
  --   config = function()
  --     require("nvim-surround").setup()
  --   end
  -- },
  -- ["nvim-treesitter/nvim-treesitter-textobjects"] = { },
  -- Extras for LSP
  ["glepnir/lspsaga.nvim"] = {
    -- after = "null-ls.nvim",
    module = "lspsaga",
    config = function()
      require("lspsaga").setup({
        ui = {
          border = "rounded",
        },
        move_in_saga = {
          prev = "<C-p>", next = "<C-n>",
        },
        -- saga_winblend = 15,
        diagnostic_header = { " ", " ", " ", "ﯧ " },
        -- show_diagnostic_source = true,
        max_preview_lines = 300,
        definition_action_keys = {
          quit = "q",
          -- edit = "o",
          vsplit = "v",
          split = "s",
          tabe = "<C-t>"
        },
        -- rename_action_quit = "<C-c>",
        -- rename_in_select = true,
        symbol_in_winbar = {
          in_custom = false,
          enable = false,
          separator = "  ",
          show_file = true,
          click_support = false,
        },
        lightbulb = {
          enable = false,
        }
      })
    end
  },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    module = "null-ls",
    config = function()
      require("null-ls").setup {
        debug = false,
        -- sources = {
        --   require("null-ls").builtins.hover.printenv.with({
        --     filetypes = {}
        --   }),
        -- },
        on_attach = function(client, bufnr)
          require("custom.plugins.lsp").on_attach(client, bufnr)
          client.server_capabilities.definitionProvider = false
          client.server_capabilities.completionProvider = false
          client.server_capabilities.signatureHelpProvider = false
          client.server_capabilities.declarationProvider = false
          client.server_capabilities.implementationProvider = false
          client.server_capabilities.typeDefinitionProvider = false
          client.server_capabilities.referencesProvider = false
          client.server_capabilities.inlayHintProvider = false
        end,
        border = "rounded",
      }
    end
  },
  -- LSP for specific filetypes
  ["mfussenegger/nvim-jdtls"] = {
    opt = true,
  },
  ["jose-elias-alvarez/typescript.nvim"] = {
    opt = true,
  },
  -- ["p00f/clangd_extensions.nvim"] = {
  --   opt = false,
  --   setup = function()
  --     vim.g.loaded_clangd_ext = true
  --   end
  -- },
  -- fzf for telescope
  ["nvim-telescope/telescope-fzf-native.nvim"] = { run = "make" },
  -- Entirety of Nvim-Dap
  ["mfussenegger/nvim-dap"] = {
    module = "dap",
    ft = { "c", "cpp" },
    config = function()
      require("custom.plugins.dap").setup()
    end,
    -- setup = function()
    --   require("core.utils").load_mappings("dap")
    -- end
  },
  ["rcarriga/cmp-dap"] = {
    after = "nvim-dap",
    config = function()
      require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
        sources = {
          { name = "dap" },
        }
      })
    end
  },
  ["theHamsta/nvim-dap-virtual-text"] = {
    after = "nvim-dap",
    config = function()
      require("nvim-dap-virtual-text").setup()
    end
  },
  ["rcarriga/nvim-dap-ui"] = {
    after = "nvim-dap",
    config = function()
      require("custom.plugins.dap.ui")
    end
  },

  ["nvim-tree/nvim-web-devicons"] = {},
  ["nvim-tree/nvim-tree.lua"] = {
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
            "parser",
            "parser-info"
            -- "^plugin/*_compiled.*",
          },
          exclude = {
            ".gitignore",
            ".gitmodules",
            ".luarc.json",
            ".eslintrc.json",
            ".exrc",
            ".nvimrc",
            ".nvim.lua",
            ".editorconfig",
          }
        },
        disable_netrw = true,
        hijack_netrw = true,
        ignore_ft_on_setup = { "alpha", "dashboard", "aerial", "mind" },
        open_on_setup = false,
        open_on_setup_file = false,
        open_on_tab = false,
        sort_by = "extension",
        hijack_cursor = false,
        hijack_unnamed_buffer_when_opening = false,
        sync_root_with_cwd = true,
        update_focused_file = {
          enable = true,
          update_cwd = false,
        },
        -- remove_keymaps = {
        --   "d",
        -- },
        view = {
          side = vim.g.nvimtree_side,
          -- adaptive_size = true,
          -- centralize_selection = true,
          width = 25,
          hide_root_folder = false,
          preserve_window_proportions = true,
          signcolumn = "yes",
          mappings = {
            -- custom_only = true,
            list = {
              { key = "d", action = "trash", },
            }
          },
          float = {
            enable = false,
            open_win_config = { -- nvim_open_win
              relative = "editor",
              row = 0,
              col = 0,
            }
          }
        },
        git = {
          enable = true,
          show_on_open_dirs = false,
          ignore = false,
          timeout = 5000,
        },
        diagnostics = {
          enable = false,
          show_on_dirs = false,
          show_on_open_dirs = false,
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
            resize_window = true,
            -- window_picker = {
            --   exclude = {
            --     filetype = { "dap-repl" },
            --     buftype = { "prompt" },
            --   }
            -- }
          },
          change_dir = {
            enable = false,
            restrict_above_cwd = true,
            -- global = true,
          }
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
            glyphs = {
              default = "",
              symlink = "",
              folder = {
                default = "",
                empty = "",
                empty_open = "",
                open = "",
                symlink = "",
                symlink_open = "",
                arrow_open = "",
                arrow_closed = "",
              },
              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
              },
            },
          },
          special_files = {
            "Cargo.toml", "Makefile", "README.md", "readme.md", "OMakefile",
          }
        },
      })
    end,
    setup = function()
      vim.keymap.set("n", "<C-n>", "<Cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
    end
  },
  -- Git?
  ["sindrets/diffview.nvim"] = {
    after = "gitsigns.nvim",
    config = function()
      require("core.utils").load_mappings("diff")
      require("diffview").setup({
        enhanced_diff_hl = true,
        view = {
          merge_tool = {
            layout = "diff3_mixed",
            disable_diagnostics = true,
          }
        }
      })
    end
  },
  --------------Plugins in NvChad---------------------------

  ["NvChad/base46"] = {
    rm_default_opts = true,
    lock = true, -- Maybe we will return to v2.0 someday, not sure
    -- run = ":CompileNvTheme",
    module = "base46",
    branch = "dev",
    commit = "1f353132de22be592ae49f7b57eeb1a21bd8a3a3",
    -- rm_default_opts = true
  },
  ["NvChad/extensions"] = {
    rm_default_opts = true,
    lock = true, -- Maybe we will return to v2.0 someday, not sure
    commit = "3920c4764b57b972e7308ede2ee33f1d03252cbb",
    -- lock = true,
  },
  ["lewis6991/gitsigns.nvim"] = {
    rm_default_opts = true,
    opt = true,
    config = function()
      loadfile(vim.g.base46_cache .. "git")()
      local null = require("null-ls")

      require("gitsigns").setup({
        signs = {
          add = { hl = "DiffAdd", text = "┃", numhl = "GitSignsAddNr" },
          change = { hl = "DiffChange", text = "┃", numhl = "GitSignsChangeNr" },
          delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
          topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
          changedelete = { hl = "DiffChangeDelete", text = "~", numhl = "GitSignsChangeNr" },
          untracked = { hl = "DiffAdded", text = "?", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
        },
        sign_priority = 0,
        current_line_blame = true,
        current_line_blame_opts = {
          delay = 400,
        },
        max_file_length = 3000,
        on_attach = function(bufnr)
          require("core.utils").load_mappings("gitsigns", { buffer = bufnr })
        end
      })
      null.register({
        null.builtins.code_actions.gitsigns
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
        end
      })
    end
  },
  ["wbthomason/packer.nvim"] = {
    cmd = { "PackerSync", "PackerLoad", "PackerStatus", "PackerCompile" },
  },
  ["nvim-lua/plenary.nvim"] = { rm_default_opts = true },
  ["williamboman/mason.nvim"] = {
    rm_default_opts = true,
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
  ["lukas-reineke/indent-blankline.nvim"] = {
    rm_default_opts = true,
    event = "BufRead",
    config = function()
      loadfile(vim.g.base46_cache .. "blankline", "b")()
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
    end
    -- disable = true
  },
  ["neovim/nvim-lspconfig"] = {
    rm_default_opts = true,
    config = function()
      local utils = require("custom.plugins.lsp")
      local on_attach = utils.on_attach
      local capabilities = utils.set_capabilities()

      utils.lsp_handlers()
      require("custom.plugins.lsp.config.defaults")(on_attach, capabilities)
      require("custom.plugins.lsp.config.custom")(on_attach, capabilities)
    end
  },
  ["rafamadriz/friendly-snippets"] = {
    rm_default_opts = true,
    -- event = "InsertEnter",
    -- keys = { ":", "/" },
  },
  ["hrsh7th/nvim-cmp"] = {
    rm_default_opts = true,
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
      require("custom.plugins.cmp")
    end
  },
  ["L3MON4D3/LuaSnip"] = {
    rm_default_opts = true,
    after = "nvim-cmp",
    config = function()
      require("luasnip").config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
      })
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.g.luasnippets_path, } })

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
  ["saadparwaiz1/cmp_luasnip"] = { after = "nvim-cmp" },
  ["hrsh7th/cmp-nvim-lsp"] = { after = "nvim-cmp", },
  ["hrsh7th/cmp-buffer"] = { after = "nvim-cmp", },
  ["hrsh7th/cmp-path"] = { after = "nvim-cmp", },
  -- ["hrsh7th/cmp-cmdline"] = { after = "nvim-cmp" },
  ["windwp/nvim-autopairs"] = {
    rm_default_opts = true,
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
    end
  },
  ["nvim-telescope/telescope.nvim"] = {
    rm_default_opts = true,
    -- after = "telescope-fzf-native.nvim",
    module = "telescope",
    cmd = { "Telescope" },
    config = function()
      require("custom.plugins.telescope")
    end,
    setup = function()
      require("core.utils").load_mappings("telescope")
    end
  },

  ["NvChad/nvim-colorizer.lua"] = {
    rm_default_opts = true,
    event = "BufReadPre",
    config = function()
      require("colorizer").setup({
        filetypes = {
          "lua", "vim",
          "vue", "tsx", "js",
          "html",
          "css", "scss",
          "xml",
          "TelescopeResults",
        },
        user_default_options = {
          RGB = false, -- #RGB hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          names = true, -- "Name" codes like Blue or blue
          RRGGBBAA = true, -- #RRGGBBAA hex codes
          AARRGGBB = false, -- 0xAARRGGBB hex codes
          rgb_fn = true, -- CSS rgb() and rgba() functions
          hsl_fn = true, -- CSS hsl() and hsla() functions
          css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
          -- Available modes for `mode`: foreground, background,  virtualtext
          mode = "background", -- Set the display mode.
          -- Available methods are false / true / "normal" / "lsp" / "both"
          -- True is same as normal
          tailwind = false, -- Enable tailwind colors
          -- parsers can contain values used in |user_default_options|
          virtualtext = "■",
        },
      })
    end
  },
  ["numToStr/Comment.nvim"] = {
    rm_default_opts = true,
    after = "nvim-ts-context-commentstring",
    config = function()
      require("core.utils").load_mappings("comment")
      require("Comment").setup({
        mappings = {
          basic = false,
          extra = false,
        },
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
      })
    end
  },
  ["/home/lucario387/config_nvchad/nvim-treesitter"] = {
    rm_default_opts = true,
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        parser_install_dir = vim.fn.stdpath("data") .. "/site",
        ensure_installed = {
          "lua", "vim", "help",
          "c", "cpp", "java", "python",
          "html", "css", "scss",
          "javascript", "typescript", "tsx", "vue",
          "json", "jsonc", "yaml", "toml",
          "comment", "jsdoc", "todotxt",
          "markdown", "markdown_inline", "mermaid",
          "gitattributes", "gitcommit", "diff", "gitignore", "git_rebase",
          "regex", "query", "scheme",
          "bash",
          "sxhkdrc", "rasi", "awk"
        },
        highlight = {
          enable = true,
          disable = function(lang, bufnr)
            if vim.tbl_contains({}, lang) then return true end
            local max_filesize = 100 * 1024 -- 100KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
          disable = {
            -- "c", "cpp",
            -- "python",
          }
        }
      })
    end
  },
  --------------Plugins in NvChad ends here------------------
}
