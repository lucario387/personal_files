local telescope = require("telescope")
vim.cmd("packadd extensions")
vim.g.theme_switcher_loaded = true
loadfile(vim.g.base46_cache .. "/telescope", "b")()
telescope.setup({
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim",
    },
    prompt_prefix = "   ",
    prompt_title = false,
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
        preview_width = 0.4,
        results_width = 0.6,
        prompt_position = "bottom",
        prompt_title = false,
      },
      width = 0.80,
      height = 0.80,
      -- preview_cutoff = 120,
    },
    -- file_ignore_patterns = { "node_modules/", "packer_compiled", "LICENSE", "%.git", "package-lock.json" },
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
    },
  },
})
local extensions = { "fzf", }
for _, ext in pairs(extensions) do
  telescope.load_extension(ext)
end
