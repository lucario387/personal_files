local M = {}

M.disabled = {

  -- Normal mode keys
  -- I dont need any of this
  n = {
    ["<leader>b"] = "",
    ["<leader>n"] = "", ["<leader>rn"] = "",
    ["<leader>e"] = "",
    ["K"] = "",

    -- Telescope
    ["<leader>gt"] = "",
    -- Lspconfig
    ["<leader>ra"] = "",
    ["gr"] = "",
    ["<leader>f"] = "", ["<leader>fm"] = "",
    ["<leader>wa"] = "", ["<leader>wr"] = "", ["<leader>wl"] = "",
    ["<leader>ls"] = "",
    ["d]"] = ""
  },
  -- Insert mode keys
}

M.general = {
  n = {
    ["A"]         = {
      function()
        vim.api.nvim_feedkeys(#vim.fn.getline(".") > 1 and "A" or "S", "n", false)
      end,
      "auto indent when enter insert on empty line"
    },
    ["I"]         = {
      function()
        vim.api.nvim_feedkeys(#vim.fn.getline(".") > 1 and "I" or "S", "n", false)
      end,
      "auto indent when enter insert on empty line"
    },
    ["x"]         = { '"_x', "" },
    ["dw"]        = { '"_dw', "" },
    ["db"]        = { '"_db', "" },
    ["cw"]        = { '"_cw', "" },
    ["cb"]        = { '"_cb', "" },
    ["<leader>y"] = { '"+y', "" },
    ["<leader>Y"] = { '"+Y', "", opts = { noremap = false } },
    ["<leader>p"] = { '"+p', "", },
    ["<leader>P"] = { '"+P', "", opts = { noremap = false }, },
    ["<C-d>"]     = { "<C-d>zz", "" },
    ["<C-u>"]     = { "<C-u>zz", "" },
    ["n"]         = { "nzz", "" },
    ["<C-h>"]     = { "<cmd>KittyMoveLeft<CR>", "", opts = { silent = true }, },
    ["<C-j>"]     = { "<cmd>KittyMoveDown<CR>", "", opts = { silent = true }, },
    ["<C-k>"]     = { "<cmd>KittyMoveUp<CR>", "", opts = { silent = true }, },
    ["<C-l>"]     = { "<cmd>KittyMoveRight<CR>", "", opts = { silent = true }, },

    ["<leader>tr"] = {
      function()
        require("base46").toggle_transparency()
      end, opts = { silent = true },
    },
    ["<C-c>"] = { "<cmd>%y+<CR>", "", opts = { silent = true } },
    ["<leader>q"] = { "<cmd>q<CR>", "" },
    ["<A-j>"] = { "<cmd>m+1<CR>==", "" },
    ["<A-k>"] = { "<cmd>m-2<CR>==", "" },
    ["<C-s>"] = { "<cmd>update<CR>", "" },

    ["<C-->"] = { "<C-w>2-", "" },
    ["<C-=>"] = { "<C-w>2+", "" },
    ["<C-.>"] = { "<C-w>2>", "" },
    ["<C-,>"] = { "<C-w>2<", "" },
    ["<leader>cc"] = {
      function()
        -- from nullchilly/nvim
        local namespaces = vim.api.nvim_get_namespaces()
        local row = vim.fn.line(".")
        local col = vim.fn.col(".")
        local hl_groups = {}
        for _, ns_id in pairs(namespaces) do
          local extmarks = vim.api.nvim_buf_get_extmarks(0, ns_id,
            { row - 1, col - 1 }, { row, col }, { details = 1 })
          for _, extmark in pairs(extmarks) do
            local new_hl_group = extmark[4].hl_group
            for _, v in ipairs(hl_groups) do
              if v == new_hl_group then
                new_hl_group = nil
              end
            end
            if new_hl_group then hl_groups[#hl_groups + 1] = new_hl_group end
          end
        end
        vim.pretty_print(hl_groups)
      end,
      "Get hlgroup under cursor",
    },
  },
  v = {
    ["<leader>y"] = { '"+y', "" },
    ["<leader>Y"] = { '"+Y', "", opts = { noremap = false } },
    ["<leader>p"] = { '"+p', "", },
    ["<leader>P"] = { '"+p', "", opts = { noremap = false } },
  },
  i = {
    -- Emacs keybind kek
    ["<C-a>"] = { "<Home><C-Right>", "" },
    ["<C-f>"] = { "<C-Right>", "" },
    ["<C-b>"] = { "<C-Left>", "" },
    ["<C-c>"] = { "<Esc>", "" },
    ["<A-j>"] = { "<Esc><cmd>m+1<CR>==a", "" },
    ["<A-k>"] = { "<Esc><cmd>m-2<CR>==a", "" },
    ["<C-A-v>"] = { "<Esc><cmd>PasteImg<CR>", "" }
  },
  x = {
    ["x"] = { '"_x', "" },
    [">"] = { ">gv", "" },
    ["<"] = { "<gv", "" },
    ["<A-j>"] = { ":m'>+1<CR>==gv", "", opts = { silent = true } },
    ["<A-k>"] = { ":m'<-2<CR>==gv", "", opts = { silent = true } },
  },
}

M.lspconfig = {
  n = {
    ["K"] = {
      function()
        vim.lsp.buf.hover()
        -- require("lspsaga.hover"):render_hover_doc()
      end, "", opts = { buffer = 0 },
    },
    ["gd"] = {
      function()
        vim.lsp.buf.definition()
        -- require("lspsaga.definition"):peek_definition()
      end, "", opts = { buffer = 0 },
    },
    ["<leader>rn"] = {
      function()
        vim.lsp.buf.rename()
        -- require("lspsaga.rename"):lsp_rename()
      end, "", opts = { buffer = 0 },
    },
    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format({ async = true })
      end, "", opts = { buffer = 0 },
    },
    ["<leader>gr"] = {
      function()
        require("lspsaga.finder"):lsp_finder()
      end, ""
    },
    ["gs"] = {
      function()
        vim.lsp.buf.signature_help()
      end, "",
    },
    ["<leader>ds"] = {
      function()
        vim.diagnostic.open_float()
        -- require("lspsaga.diagnostic"):show_line_diagnostics()
      end, "", opts = { buffer = 0 }
    },
    ["<leader>ca"] = {
      function()
        -- vim.lsp.buf.code_action()
        require("lspsaga.codeaction"):code_action()
      end,
      "", opts = { buffer = 0 },
    },
    ["[d"] = {
      function()
        vim.diagnostic.goto_prev()
        -- require("lspsaga.diagnostic"):goto_prev({wrap = true})
      end,
      "goto prev diagnostic",
    },
    ["]d"] = {
      function()
        vim.diagnostic.goto_next()
        -- require("lspsaga.diagnostic"):goto_next()
      end,
      "goto next diagnostic"
    }
  }
}

-- Specific for jdtls
M.jdtls = {
  plugin = true,
  n = {
    ["<A-o>"] = {
      function()
        require("jdtls").organize_imports()
      end, "Organize Imports"
    },
    ["<leader>jv"] = {
      function()
        require("jdtls").extract_variable()
      end, "Extract Variable"
    },
    ["<S-F6>"] = { -- <S-F6>
      function()
        require("jdtls").test_class()
      end, "Test Class"
    },
    ["<leader>df"] = {
      function()
        require("jdtls").test_nearest_method()
      end,
      "Test nearest method"
    },
  },
  v = {
    ["<leader>jv"] = {
      function()
        require("jdtls").extract_variable(true)
      end, "Extract variable"
    },
    ["<leader>jc"] = {
      function()
        require("jdtls").extract_constant(true)
      end, "Extract constant"
    },
    ["<leader>jm"] = {
      function()
        require("jdtls").extract_method(true)
      end, "Extract method"
    }
  }

}

M.telescope = {
  n = {
    ["<leader>ff"] = {
      "<cmd>Telescope find_files prompt_title=false<CR>",
      "find files",
    },

    ["<leader>tm"] = {
      '<cmd>Telescope man_pages prompt_title=false sections={"ALL"}<CR>',
      ""
    },
  }
}

M.tabline = {
  plugin = true,
  n = {
    ["<leader>x"] = {
      function() require("custom.ui.tabline.utils").close_buffer() end, ""
    },
    ["<Tab>"] = {
      function() require("custom.ui.tabline.utils").next_buffer() end, ""
    },
    ["<S-Tab>"] = {
      function() require("custom.ui.tabline.utils").prev_buffer() end, ""
    }
  },
}

M.dap = {
  plugin = true,
  n = {
    -- following what Vscode do with its debugging hotkeys
    ["<F5>"] = {
      "<cmd>DapContinue<CR>",
      "Continue/Start a Debug Session",
    },
    ["<F17>"] = { --Shift F5 is F17
      "<cmd>DapTerminate<CR>",
      "Close current debug session",
    },
    -- C-S-F5 is not an accepted keymap (unless you modify it) so using C-F5 instead
    ["<F29>"] = { -- Ctrl F5 is F29
      function()
        vim.notify("Debug Session Restarting")
        -- :h dap.terminate()
        require("dap").terminate({}, { terminateDebuggee = true }, function() require("dap").run_last() end)
        -- require("dap").run_last()
      end,
      "Restart a debug session",
    },
    ["<F10>"] = {
      "<cmd>DapStepOver<CR>",
      "DAP Step Over",
    },
    ["<F11>"] = {
      "<cmd>DapStepInto",
      "DAP Step Into",
    },
    ["<F23>"] = {
      "<cmd>DapStepOut<CR>",
      "DAP Step Out",
    },
    ["<leader>b"] = {
      "<cmd>DapToggleBreakpoint<CR>",
      "Toggle breakpoint on current line",
    },
    ["<leader>do"] = {
      function()
        require("dap.repl").toggle()
      end,
      "Toggle REPL"
    },
    ["<leader>du"] = {
      function()
        require("dapui"):toggle()
      end,
      "Toggle dapui"
    },
    -- ["<leader>dl"] = {
    -- 	function() require("dap").run_last() end,
    -- 	opts = { desc = "Run " }
    -- }
  }
}

M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },

    -- focus
    ["<leader>e"] = { "<cmd> NvimTreeFocus <CR>", "focus nvimtree" },
  },
}

M.persisted = {
  plugin = true,
  n = {
    ["<leader>rs"] = {
      function()
        require("persisted").load()
      end, ""
    },
    ["<leader>ss"] = {
      function()
        require("persisted").save()
      end, ""
    },
  }
}
return M