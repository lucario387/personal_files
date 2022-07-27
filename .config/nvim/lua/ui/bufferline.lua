local mappings = {
  n = {
    -- Bufferline stuffs
    ["<leader>x"] = {
      callback = "<cmd> bp|sp|bn|bd!<CR>",
      opts = { desc = "Close buffer", noremap = true, silent = true, },
    },
    ["<Tab>"] = {
      callback = "<cmd>BufferLineCycleNext<CR>",
      opts = { noremap = true, silent = true },
    },
    ["<S-Tab>"] = {
      callback = "<cmd>BufferLineCyclePrev<CR>",
      opts = { noremap = true, silent = true },
    },
  }
}

require("bufferline").setup({
  options = {
    mode = "buffers",
    numbers = "none",
    close_command = "bp|sp|bn|bd! %d",
    right_mouse_command = "bp|sp|bn|bd! %d",
    left_mouse_command = "buffer %d",
    offsets = {
      {
        filetype = "NvimTree",
        text = "",
      }
    },
    show_buffer_close_icons = false,
    show_close_icon = false,
    seperator_style = "thin",
    themable = true,
    diagnostics = "nvim_lsp",
  }
})

require("mappings").setkeymaps(mappings)
