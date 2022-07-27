local M = {}

local neorg_icons = {
  todo = {
    pending = {
      icon = "",
    },
    uncertain = {
      icon = "?",
    },
    urgent = {
      icon = "",
    },
    on_hold = {
      icon = "",
    },
    cancelled = {
      icon = "",
    },
  },

  list = {
    level_1 = {
      icon = "",
    },

    icon = " ",
    level_2 = {
    },

    level_3 = {
      icon = "  ",
    },

    level_4 = {
      icon = "   ",
    },

    level_5 = {
      icon = "    ",
    },

    level_6 = {
      icon = "     ",
    },
  },
  heading = {

    level_1 = {
      icon = "",
    },

    level_2 = {
      icon = " ",
    },

    level_3 = {
      icon = "  ",
    },

    level_4 = {
      enabled = true,
      icon = "   ﰟ",
    },

    level_5 = {
      icon = "    ▶",
    },

    level_6 = {
      icon = "     ⤷",
    },
  }
}

M.neorg = function()
  vim.g.neorg_indent = true

  require("neorg").setup({
    load = {
      ["core.defaults"] = {},

      ["core.presenter"] = {
        config = {
          zen_mode = "truezen",
        },
      },

      ["core.norg.dirman"] = {
        config = {
          workspaces = {
            work  = "~/Documents/notes/work",
            study = "~/Documents/notes/study",
            linux = "~/Documents/notes/linux",
          }
        }
      },

      ["core.norg.concealer"] = {
        config = {
          icon_preset = "varied",
          icons = {
            todo    = neorg_icons.todo,
            list    = neorg_icons.list,
            heading = neorg_icons.heading,
          },
          dim_code_blocks = {
            width = "content",
            content_only = true,
            padding = {
              left = 10,
              right = 10,
            }
          }
        },
      },

      ["core.norg.completion"] = {
        config = {
          engine = "nvim-cmp",
        }
      },

      ["core.norg.esupports.metagen"] = {
        config = {
          type = "auto",
        }
      }
    }
  })
end

M.truezen = function()
  require("true-zen").setup({
    modes = {
      ataraxis = {
        minimum_writing_area = {
          width = 100,
          height = 30,
        },
        quit_untoggles = true,
        callbacks = {
          open_pre = function()
            vim.opt.relativenumber = false
            vim.opt.laststatus = 0
          end,
          close_pos = function()
            vim.opt.laststatus = 3
            vim.opt.relativenumber = true
            vim.opt.number = true
          end
        }
      }
    }
  })
end

M.mind = function()
  require("mind").setup({
    ui = {
      width = 25;
    }
  })
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("MindNoRelNum", {clear = true}),
    pattern = "mind",
    callback = function()
    end
  })
end

M.femaco = function()
  require("femaco").setup({
    post_open_float = function(winnr)
      vim.wo.signcolumn = "no"
      vim.wo.number = false
      vim.wo.relativenumber = false
    end
  })
end
return M
