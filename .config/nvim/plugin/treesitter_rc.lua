require("nvim-treesitter.configs").setup({
  auto_install = true,
  parser_install_dir = vim.fn.stdpath("data") .. "/site",
  ensure_installed = { "vim", "lua", "c" },
  ignore_install = {
    "latex",
  },
  highlight = {
    enable = true,
    disable = function(lang, bufnr)
      if vim.tbl_contains({}, lang) then
        return true
      end
      local max_filesize = 100 * 1024 -- 100kb
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
      "python",
    },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<cr>",
      node_incremental = "<cr>",
      scope_incremental = "<Nop>",
      node_decremental = "<bs>",
    }
  },
})
