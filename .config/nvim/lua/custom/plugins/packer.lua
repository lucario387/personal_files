return {
  --------------Removed plugins-----------------------------
  ["folke/which-key.nvim"] = false,
  ["goolord/alpha-nvim"] = false,
  ["NvChad/nvterm"] = false,
  ["NvChad/ui"] = false,
  ["hrsh7th/cmp-nvim-lua"] = false,
  ["kyazdani42/nvim-tree.lua"] = false,
  ["kyazdani42/nvim-web-devicons"] = false,
  -- ["windwp/nvim-autopairs"] = false,
  ----------------------------------------------------------
  --------------Plugins not in NvChad-----------------------
  -- General
  -- Treesitter related stuffs
  ["andymass/vim-matchup"] = {
    event = "BufRead",
    config = function()
      require("nvim-treesitter.configs").setup({
        matchup = {
          enable = true,
          include_match_words = true,
        },
      })
    end
  },
  ["windwp/nvim-ts-autotag"] = {
    event = "InsertEnter",
    config = function()
      require("nvim-treesitter.configs").setup({
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
  ["kylechui/nvim-surround"] = {
    event = "BufRead",
    config = function()
      require("nvim-surround").setup()
    end
  },
  -- Extras for LSP
  ["glepnir/lspsaga.nvim"] = {
    module = "lspsaga",
    config = function()
      local saga = require("lspsaga")
      saga.init_lsp_saga({
        border_style = "rounded",
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
        code_action_lightbulb = {
          enable = false,
        }
      })
    end
  },
  -- ["zbirenbaum/neodim"] = {
  --   -- event = "LspAttach",
  --   config = function()
  --     require("neodim").setup({
  --       alpha = 0.75,
  --       hide = {
  --         virtual_text = true,
  --         underline = true,
  --         signs = false,
  --       }
  --     })
  --   end,
  -- },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    module = "null-ls",
    config = function()
      local null = require("null-ls")
      -- local c_filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", }

      null.setup {
        debug = false,
        -- sources = {
        --   null.builtins.hover.dictionary
        -- },
        -- should_attach = function(bufnr)
        --   return not vim.tbl_contains(c_filetypes, vim.api.nvim_buf_get_option(bufnr, "ft"))
        -- end,
        on_attach = function(client, bufnr)
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
  -- ["p00f/clangd_extensions.nvim"] = {
  --   ft = { "c", "cpp" },
  --   config = function()
  --     require("custom.plugins.lsp.servers.clangd")(
  --       require("custom.plugins.lsp.utils").on_attach,
  --       require("custom.plugins.lsp.utils").set_capabilities()
  --     )
  --   end
  -- },
  -- fzf for telescope
  ["nvim-telescope/telescope-fzf-native.nvim"] = { run = "make", },
  -- Entirety of Nvim-Dap
  ["mfussenegger/nvim-dap"] = {
    module = "dap",
    cmd = {
      "DapToggleBreakpoint",
      "DapContinue",
      "DapTerminate",
      "DapStepOver",
      "DapStepInto",
      "DapStepOut",
    },
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
      require("nvim-dap-virtual-text").setup {
        -- enable this plugin (the default)
        enabled = true,
        -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh
        -- for refreshing when debug adapter did not notify its termination)
        enabled_commands = true,
        -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
        highlight_changed_variables = true,
        -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
        highlight_new_as_changed = true,
        -- show stop reason when stopped for exceptions
        show_stop_reason = true,
        -- prefix virtual text with comment string
        commented = false,
        -- only show virtual text at first definition (if there are multiple)
        only_first_definition = true,
        -- show virtual text on all all references of the variable (not only definitions)
        all_references = true,
        -- filter references (not definitions) pattern when all_references is activated
        -- (Lua gmatch pattern, default filters out Python modules)
        filter_references_pattern = "<module",
        -- experimental features:
        -- position of virtual text, see `:h nvim_buf_set_extmark()`
        virt_text_pos = "eol",
        -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
        all_frames = false,
        -- show virtual lines instead of virtual text (will flicker!)
        virt_lines = false,
        -- position the virtual text at a fixed window column (starting from the first text column) ,
        -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
        virt_text_win_col = nil,
      }
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
        -- on_attach = function(bufnr)
        --   local inject_node = require("nvim-tree.utils").inject_node
        --   vim.keymap.set("n",
        --     "<C-k>",
        --     "<cmd>KittyMoveUp<CR>",
        --     { silent = true, buffer = bufnr, noremap = true })
        --   vim.keymap.set("n", "K", inject_node(function(node)
        --     node = node or require("nvim-tree.lib").get_node_at_cursor()
        --     require("nvim-tree.actions.node.file-popup").toggle_file_info(node)
        --   end))
        -- end,
        -- create_in_closed_folder = true,
        filters = {
          dotfiles = true,
          custom = {
            "node_modules",
            "%.git",
            "%.github",
            -- "^plugin/*_compiled.*",
          },
          exclude = {
            ".gitignore",
            ".gitmodules",
            ".luarc.json",
            ".eslintrc.json",
            ".exrc",
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
        view = {
          side = vim.g.nvimtree_side,
          -- adaptive_size = true,
          -- centralize_selection = true,
          width = 25,
          hide_root_folder = false,
          preserve_window_proportions = true,
          signcolumn = "yes",
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
          enable = false,
          debounce_delay = 100,
        },
        actions = {
          open_file = {
            resize_window = true,
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
    -- setup = function()
    --   require("core.utils").load_mappings("nvimtree")
    -- end
  },
  ["MunifTanjim/nui.nvim"] = {
    -- event = "VimEnter",
  },
  ["folke/noice.nvim"] = {
    event = "VimEnter",
    -- disable = true,
    -- after = "nui.nvim",
    config = function()
      local noice = require("noice")
      noice.setup({
        cmdline = {
          enabled = true,
        },
        messages = {
          enabled = true,
        },
        notify = {
          enabled = false,
        },
        popupmenu = {
          enabled = true,
          backend = "nui",
        },
        health = {
          checker = false,
        },
        smart_move = {
          excluded_filetypes = {
            "noice",
          },
        },
        lsp = {
          progress = {
            enabled = false,
          },
          override = {
            -- override the default lsp markdown formatter with Noice
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            -- override the lsp markdown formatter with Noice
            ["vim.lsp.util.stylize_markdown"] = true,
            -- override cmp documentation with Noice (needs the other options to work)
            ["cmp.entry.get_documentation"] = false,
          },
          message = {
            enabled = true,
            view = "mini",
          },
          signature = {
            enabled = true,
            auto_open = {
              luasnip = true,
              throttle = 100,
            }
          },
          documentation = {
            win_options = {
              concealcursor = "nv",
            }
          }
        },
        presets = {
          bottom_search = true,
          long_message_to_split = true,
          lsp_doc_border = true,
          command_palette = true,
          -- inc_rename = true,
        },
        views = {
          cmdline_popup = {
            position = {
              row = -2,
              col = "0%",
            }
          },
          popupmenu = {
            size = {
              max_height = 20,
            },
            enter = true,
            focusable = true,
            win_options = {
              winhighlight = {
                Normal = "NormalFloat",
                FloatBorder = "FloatBorder"
              },
            },
          },
          hover = {
            border = {
              padding = { 0, 0 },
            },
          },
        }
      })
    end,
  },
  -- ["folke/neodev.nvim"] = {},
  ["sindrets/diffview.nvim"] = {
    opt = true,
    cmd = {
      "DiffviewFileHistory",
      "DiffviewToggleFiles",
      "DiffviewOpen",
      "DiffviewFocusFiles"
    },
  },
  -- Git?

  -- Eye candy
  ["andweeb/presence.nvim"] = {
    disable = true,
    -- opt = true,
    config = function()
      require("presence"):setup({
        -- Update activity based on autocmd events
        -- (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
        auto_update        = true,
        -- Text displayed when hovered over the Neovim image
        neovim_image_text  = "Papage",
        -- Main image display (either "neovim" or "file")
        main_image         = "neovim",
        -- Use your own Discord application client id (not recommended)
        -- client_id          = "793271441293967371",
        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
        log_level          = nil,
        -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
        debounce_timeout   = 10,
        -- Displays the current line number instead of the current project
        enable_line_number = false,
        -- A list of strings or Lua patterns that disable Rich Presence if
        -- the current file name, path, or workspace matches
        blacklist          = { vim.env.HOME .. "/work" },
        -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table
        -- (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
        buttons            = true,
        -- Custom file asset definitions keyed by file names and
        -- extensions (see default config at `lua/presence/file_assets.lua` for reference)
        file_assets        = {},
        -- Show the timer
        show_time          = true,
        -- Rich Presence text options

        -- Format string rendered when an editable file is loaded in the buffer
        -- (either string or function(filename: string): string)
        editing_text        = "Breaking %s",
        -- Format string rendered when browsing a file explorer
        -- (either string or function(file_explorer_name: string): string)
        file_explorer_text  = "Idling",
        -- Format string rendered when committing changes in git
        -- (either string or function(filename: string): string)
        git_commit_text     = "Committing changes",
        -- Format string rendered when managing plugins
        -- (either string or function(plugin_manager_name: string): string)
        plugin_manager_text = "Managing plugins",
        -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer
        -- (either string or function(filename: string): string)
        reading_text        = "Reading %s",
        -- Format string rendered when in a git repository
        -- (either string or function(project_name: string|nil, filename: string): string)
        workspace_text      = "Gliding thru %s",
        -- Format string rendered when `enable_line_number` is set to true
        -- (either string or function(line_number: number, line_count: number): string)
        line_number_text    = "Line %s out of %s",
      })
    end
  },
  --------------Plugins in NvChad---------------------------

  ["NvChad/base46"] = {
    run = ":CompileNvTheme",
    -- module = "base46",
    -- branch = "dev",
    -- rm_default_opts = true
  },
  ["lewis6991/gitsigns.nvim"] = {
    ft = {},
    config = function()
      loadfile(vim.g.base46_cache .. "git")()
      local null = require("null-ls")
      local options = {
        signs = {
          add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
          change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
          delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
          topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
          changedelete = { hl = "DiffChangeDelete", text = "~", numhl = "GitSignsChangeNr" },
          untracked = { hl = "DiffAdded", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
        },
        sign_priority = 0,
        current_line_blame = false,
        current_line_blame_opts = {
          delay = 400,
        },
        max_file_length = 10000,
        on_attach = function(bufnr)
          require("core.utils").load_mappings("gitsigns", { buffer = bufnr })
        end
      }

      require("gitsigns").setup(options)
      null.register({
        null.builtins.code_actions.gitsigns
      })
    end
  },
  ["wbthomason/packer.nvim"] = {
    cmd = { "PackerSync", "PackerLoad", "PackerStatus" },
  },
  ["nvim-lua/plenary.nvim"] = { rm_default_opts = true },
  ["williamboman/mason.nvim"] = {
    rm_default_opts = true,
    cmd = "Mason",
    config = function()
      require("mason").setup({

        PATH = "skip",
        ui = {
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
  ["nvim-treesitter/nvim-treesitter"] = {
    rm_default_opts = true,
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        ensure_installed = {
          "lua", "vim", "help",
          "c", "cpp",
        },
        incremental_selection = {
          enable = false,
        },
        highlight = {
          enable = true,
          disable = function(lang, bufnr)
            local max_filesize = 100 * 1024 -- 100KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end
        },
        indent = {
          enable = true,
          disable = {
            "c", "cpp",
            "python",
          }
        }
      })
    end
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
      local lspconfig = require("lspconfig")

      local utils = require("custom.plugins.lsp")
      local on_attach = utils.on_attach
      local capabilities = utils.set_capabilities()

      utils.lsp_handlers()

      local default_servers = {
        "html",
        "cssls",
        -- "sqlls",
      }

      for _, server_name in pairs(default_servers) do
        lspconfig[server_name].setup({
          on_attach = on_attach,
          capabilities = capabilities
        })
      end

      local custom_servers = {
        -- "bashls",
        "pyright",
        "jsonls",
        -- "js",
        "clangd",
        "sumneko",
        "vue",
        "eslint",
      }

      for _, server_name in pairs(custom_servers) do
        require("custom.plugins.lsp.servers." .. server_name)(on_attach, capabilities)
      end
    end
  },
  ["rafamadriz/friendly-snippets"] = {
    rm_default_opts = true,
    event = "InsertEnter",
  },
  ["L3MON4D3/LuaSnip"] = {
    rm_default_opts = true,
    after = "friendly-snippets",
    config = function()
      require("luasnip").config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
      })
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.g.luasnippets_path, } })

      vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
          if require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
            and not require("luasnip").session.jump_active
          then
            require("luasnip").unlink_current()
          end
        end,
      })
    end,
  },
  ["hrsh7th/nvim-cmp"] = {
    rm_default_opts = true,
    after = "LuaSnip",
    config = function()
      local cmp = require("cmp")
      loadfile(vim.g.base46_cache .. "cmp")()

      local ELLIPSIS_CHAR = "…"
      local MAX_LABEL_WIDTH = 40
      local icons = require("custom.ui.icons").lspkind
      local function border(hl_name)
        return {
          { "╭", hl_name },
          { "─", hl_name },
          { "╮", hl_name },
          { "│", hl_name },
          { "╯", hl_name },
          { "─", hl_name },
          { "╰", hl_name },
          { "│", hl_name },
        }
      end

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
      end

      local disabled_buftypes = {
        "terminal",
        -- "nofile",
        "prompt",
      }
      local menu = {
        nvim_lsp = "(LSP)",
        path = "(Path)",
        buffer = "(Buf)",
        luasnip = "(Snip)",
        neorg = "(Norg)",
        nvim_lua = "(Nvim)",
      }

      local options = {
        enabled = function()
          local disabled = false
          disabled       = disabled or (vim.tbl_contains(disabled_buftypes, vim.api.nvim_buf_get_option(0, "buftype")))
          -- disabled       = disabled or (vim.fn.reg_recording() ~= "")
          disabled       = disabled or (vim.fn.reg_executing() ~= "")
          if disabled then return not disabled end

          local context = require("cmp.config.context")
          -- keep command mode completion enabled when cursor is in a comment
          if vim.api.nvim_get_mode().mode == "c" then
            return true
          else
            return not context.in_treesitter_capture("comment")
              and not context.in_syntax_group("Comment")
          end
        end,
        window = {
          completion = {
            border = border "CmpBorder",
            winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
            side_padding = 0,
            scrollbar = true,
          },
          documentation = {
            border = border "CmpDocBorder",
          },
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          },
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
              require("luasnip").expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s", }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              require("luasnip").jump(-1)
            else
              fallback()
            end
          end, { "i", "s", }),
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          -- fields = { "abbr", "kind", "menu" },
          format = function(entry, vim_item)
            vim_item.menu = menu[entry.source.name]
            -- vim_item.kind = string.format("%s%s", icons[vim_item.kind], vim_item.kind)
            vim_item.kind = string.format("%s", icons[vim_item.kind])
            if #vim_item.abbr > MAX_LABEL_WIDTH then
              vim_item.abbr = string.sub(vim_item.abbr, 1, MAX_LABEL_WIDTH - 1) .. ELLIPSIS_CHAR
            end
            return vim_item
          end,
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip", keyword_length = 4, max_item_count = 20 },
          { name = "path", keyword_length = 2 },
          { name = "buffer", keyword_length = 5 },
        },
      }

      -- check for any override

      cmp.setup(options)

      -- cmp.setup.filetype("lua", {
      --   sources = cmp.config.sources({
      --     { name = "nvim_lua" },
      --   })
      -- })

      -- cmp.setup.filetype("norg", {
      --   sources = cmp.config.sources({
      --     {name = "neorg"},
      --   })
      -- })
    end,
  },
  ["saadparwaiz1/cmp_luasnip"] = { after = "nvim-cmp" },
  ["hrsh7th/cmp-nvim-lsp"] = { after = "nvim-cmp", },
  ["hrsh7th/cmp-buffer"] = { after = "nvim-cmp", },
  ["hrsh7th/cmp-path"] = { after = "nvim-cmp", },
  ["windwp/nvim-autopairs"] = {
    -- rm_default_opts = true,
    -- event = "InsertEnter",
    config = function()
      local autopairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      autopairs.setup({
        fast_wrap = {},
        disable_filetype = { "TelescopePrompt", "vim" },
      })

      require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

      autopairs.add_rules({
        Rule("%<%>$", "</>", { "typescript", "typescriptreact", "javascript", "javascriptreact" })
          :use_regex(true),
      })
    end
  },
  ["nvim-telescope/telescope.nvim"] = {
    rm_default_opts = true,
    cmd = "Telescope",
    config = function()
      local telescope = require("telescope")
      vim.g.theme_switcher_loaded = true
      loadfile(vim.g.base46_cache .. "/telescope", "b")()
      telescope.setup({
        defaults = {
          -- vimgrep_arguments = {
          --   "rg",
          --   "--color=never",
          --   "--no-heading",
          --   "--with-filename",
          --   "--line-number",
          --   "--column",
          --   "--smart-case",
          --   "--trim",
          -- },
          prompt_prefix = "   ",
          selection_caret = "  ",
          entry_prefix = "  ",
          initial_mode = "insert",
          selection_strategy = "reset",
          sorting_strategy = "ascending",
          layout_strategy = "bottom_pane",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            bottom_pane = {
              height = 15,
              preview_width = 0.6,
              results_width = 0.4,
              prompt_position = "bottom",
              prompt_title = "",
            },
            width = 0.80,
            height = 0.80,
            -- preview_cutoff = 120,
          },
          file_ignore_patterns = { "node_modules/", "packer_compiled", "LICENSE", "%.git", "package-lock.json" },
          path_display = { "truncate" },
          winblend = 0,
          border = {},
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          color_devicons = true,
          set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
          mappings = {
            n = {
              ["q"] = require("telescope.actions").close,
              ["<C-c>"] = require("telescope.actions").close,
            },
            i = { ["<C-c>"] = { "<Esc>", type = "command" } },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          }
        }
      })
      local extensions = { "fzf", "themes" }
      for _, ext in pairs(extensions) do
        telescope.load_extension(ext)
      end
    end,
  },

  ["NvChad/nvim-colorizer.lua"] = {
    rm_default_opts = true,
    event = "BufRead",
    config = function()
      require("plugins.configs.others").colorizer()
    end
  },
  ["numToStr/Comment.nvim"] = {
    rm_default_opts = true,
    after = "nvim-ts-context-commentstring",
    config = function()
      require("core.utils").load_mappings("comment")
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
      })
    end
  },
  --------------Plugins in NvChad ends here------------------
}
