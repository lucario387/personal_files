local M = {}

local set = vim.keymap.set

--- Use for null-ls and lsp
M.null_ls = function()
  set("n", "<leader>ca", function()
    vim.lsp.buf.code_action()
  end, { desc = "code action", buffer = 0 })
  set("x", "<leader>ca", function()
    require("lspsaga.codeaction"):code_action()
  end, { desc = "range code action", buffer = 0 })
end

M.general = function()
  --- Normal mode
  set("n", "<ESC>", "<cmd> noh <CR>", { desc = "no highlight" })

  -- switch between windows
  set("n", "<C-h>", "<C-w>h", { desc = "window left" })
  set("n", "<C-l>", "<C-w>l", { desc = "window right" })
  set("n", "<C-j>", "<C-w>j", { desc = "window down" })
  set("n", "<C-k>", "<C-w>k", { desc = "window up" })

  -- save
  set("n", "<C-s>", "<cmd> w <CR>", { desc = "save file" })

  -- Copy all
  set("n", "<C-c>", "<cmd> %y+ <CR>", { desc = "copy whole file" })

  set("n", "x", '"_x', { desc = "" })
  set("n", "dw", '"_dw', { desc = "" })
  set("n", "db", '"_db', { desc = "" })
  set("n", "cw", '"_cw', { desc = "" })
  set("n", "cb", '"_cb', { desc = "" })
  set("n", "<C-d>", "<C-d>zz", { desc = "" })
  set("n", "<C-u>", "<C-u>zz", { desc = "" })
  set("n", "n", "nzz", { desc = "" })
  set("n", "N", "Nzz", { desc = "" })
  set("n", "<C-c>", "<cmd>%y+<CR>", { silent = true })
  set("n", "<leader>q", "<cmd>q<CR>", { desc = "" })
  set("n", "<A-j>", "<cmd>m+1<CR>==", { desc = "" })
  set("n", "<A-k>", "<cmd>m-2<CR>==", { desc = "" })
  set("n", "<C-s>", "<cmd>update<CR>", { desc = "" })

  set("n", "<C-->", "<C-w>2-", { desc = "" })
  set("n", "<C-=>", "<C-w>2+", { desc = "" })
  set("n", "<C-.>", "<C-w>2>", { desc = "" })
  set("n", "<C-,>", "<C-w>2<", { desc = "" })

  -- ["<leader>tt"] = {
  --   function()
  --     require("base46").toggle_theme()
  --   end,
  --   "toggle theme",
  -- },
  -- ["<leader>tr"] = {
  --   function()
  --     require("base46").toggle_transparency()
  --   end,
  --   opts = { silent = true },
  -- },

  set("n", "a", function()
    local line = #vim.trim(vim.fn.getline("."))
    vim.api.nvim_feedkeys(line >= 1 and "a" or "S", "n", false)
  end, { desc = "auto indent when enter insert on empty line", buffer = 0 })
  set("n", "i", function()
    local line = #vim.trim(vim.fn.getline("."))
    vim.api.nvim_feedkeys(line >= 1 and "i" or "S", "n", false)
  end, { desc = "auto indent when enter insert on empty line", buffer = 0 })
  set("n", "A", function()
    local line = #vim.trim(vim.fn.getline("."))
    vim.api.nvim_feedkeys(line >= 1 and "A" or "S", "n", false)
  end, { desc = "auto indent when enter insert on empty line", buffer = 0 })
  set("n", "I", function()
    local line = #vim.trim(vim.fn.getline("."))
    vim.api.nvim_feedkeys(line >= 1 and "I" or "S", "n", false)
  end, { desc = "auto indent when enter insert on empty line", buffer = 0 })

  set({ "n", "v" }, "<leader>y", '"+y', { noremap = false })
  set({ "n", "v" }, "<leader>Y", '"+Y', { noremap = false })
  set({ "n", "v" }, "<leader>p", '"+p', { noremap = false })
  set({ "n", "v" }, "<leader>P", '"+P', { noremap = false })


  --- Insert mode
  -- Emacs keybind kek
  set("i", "<C-a>", "<C-o>^", { desc = "" })
  set("i", "<C-e>", "<End>", { desc = "to eol" })
  set("i", "<C-f>", "<C-Right>", { desc = "" })
  set("i", "<C-b>", "<C-Left>", { desc = "" })
  set("i", "<C-c>", "<Esc>", { desc = "" })
  -- navigate within insert mode
  set("i", "<C-h>", "<Left>", { desc = "move left" })
  set("i", "<C-l>", "<Right>", { desc = "move right" })
  set("i", "<C-j>", "<Down>", { desc = "move down" })
  set("i", "<C-k>", "<Up>", { desc = "move up" })

  set("i", "<A-j>", "<Esc><cmd>m+1<CR>==a", { desc = "" })
  set("i", "<A-k>", "<Esc><cmd>m-2<CR>==a", { desc = "" })
  set("i", "<C-A-v>", "<Esc><cmd>PasteImg<CR>", { desc = "" })

  --- Visual mode

  set("x", "x", '"_x', { desc = "" })
  set("x", ">", ">gv", { desc = "" })
  set("x", "<", "<gv", { desc = "" })
  set("x", "<A-j>", ":m'>+1<CR>gv=gv", { silent = true })
  set("x", "<A-k>", ":m'<-2<CR>gv=gv", { silent = true })
end

M.lsp = function()
  set("n", "K", function()
    vim.lsp.buf.hover()
  end, { buffer = 0 })
  set("n", "gd", function()
    require("lspsaga.definition"):goto_definition()
    -- vim.lsp.buf.definition()
  end, { desc = "Goto defintion", buffer = 0 })
  set("n", "<leader>rn", function()
    require("lspsaga.rename"):lsp_rename()
  end, { buffer = 0, desc = "LSP rename" })
  set("n", "<leader>fm", function()
    vim.lsp.buf.format({
      async = true,
    })
  end, { desc = "LSP format", buffer = 0 })
  set("n", "<leader>gr", function()
    require("lspsaga.finder"):lsp_finder()
  end, { buffer = 0 })
  set("n", "gs", function()
    vim.lsp.buf.signature_help()
  end, { desc = "Show signature", buffer = 0 })
  set("n", "<leader>ds", function()
    require("lspsaga.diagnostic"):show_diagnostics(arg, "line")
  end, { desc = "Show line diagnostic", buffer = 0 })
  set("n", "[d", function()
    require("lspsaga.diagnostic"):goto_prev({ wrap = true })
  end, { desc = "goto prev diagnostic", buffer = 0 })
  set("n", "]d", function() -- vim.diagnostic.goto_next()
    require("lspsaga.diagnostic"):goto_next()
  end, { desc = "goto next diagnostic", buffer = 0 })

  M.null_ls()
end

M.jdtls = function()

  set("n", "<A-o>", function()
    require("jdtls").organize_imports()
  end, { desc = "Jdtls organize imports", buffer = 0 })
  set("n", "<leader>jv", function()
    require("jdtls").extract_variable()
  end, { desc = "extract variable", buffer = 0 })
  set("n", "<F18>", function() -- F18 or S-F6
    require("jdtls").test_class({})
    vim.schedule(function()
      vim.cmd("stopinsert")
    end)
  end, { desc = "Test java class", buffer = 0 })
  set("n", "<F20>", function() -- F20 or S-F8
    require("jdtls").test_nearest_method()
  end, { desc = "test nearest java method", buffer = 0 })
  set("x", "<leader>jv", function() require("jdtls").extract_variable(true) end,
    { desc = "Extract variable", buffer = 0 })
  set("x", "<leader>jc", function() require("jdtls").extract_constant(true) end,
    { desc = "Extract constant", buffer = 0 })
  set("x", "<leader>jm", function() require("jdtls").extract_method(true) end, { desc = "Extract method", buffer = 0 })
end

M.telescope = function()
  set("n", "<leader>fw", "<cmd>Telescope live_grep prompt_title=false<CR>", { desc = "Live grep", })
  set("n", "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true prompt_title=false <CR>",
    { desc = "find all", })
  set("n", "<leader>ff", "<cmd>Telescope find_files prompt_title=false<CR>", { desc = "find files", })
  set("n", "<leader>tm", '<cmd>Telescope man_pages prompt_title=false sections={"ALL"}<CR>', { desc = "show man page", })
  set("n", "<leader>fk", "<cmd>Telescope keymaps prompt_title=false<CR>", { desc = "find mappings", })
end

M.git = function()
  set("n", "<leader>gdo", "<cmd>DiffviewOpen<CR>", { desc = "Open Diff view", buffer = 0 })
  set("n", "<leader>gdc", "<cmd>DiffviewClose<CR>", { desc = "Close Diff view", buffer = 0 })
  set("n", "<leader>gdr", "<cmd>DiffviewRefresh<CR>", { desc = "Refresh Diff view", buffer = 0 })

  set("n", "[c", function()
    if vim.wo.diff then
      return "[c"
    end
    vim.schedule(function()
      require("gitsigns").prev_hunk({ preview = true })
    end)
    return "<Ignore>"
  end, { expr = true, desc = "Jump to prev hunk", buffer = 0 })
  set("n", "]c", function()
    if vim.wo.diff then
      return "]c"
    end
    vim.schedule(function()
      require("gitsigns").next_hunk({ preview = true })
    end)
    return "<Ignore>"
  end, { expr = true, desc = "Jump to next hunk", buffer = 0 })

  set("n", "<leader>rh", function() require("gitsigns").reset_hunk() end, { desc = "Reset hunk", buffer = 0 })

  set("n", "<leader>ph", function() require("gitsigns").preview_hunk() end, { desc = "Preview hunk", buffer = 0 })

  set("n", "<leader>gb", function() require("gitsigns").blame_line() end, { desc = "Blame line", buffer = 0 })

  set("n", "<leader>td", function() require("gitsigns").toggle_deleted() end, { desc = "Toggle deleted", buffer = 0 })
end

M.dap = function()
  set("n", "<F5>", "<cmd>DapContinue<CR>", { desc = "Continue/start a debug session" })
  set("n", "<F17>", "<cmd>DapTerminate<CR>", { desc = "Close current debug session" })
  set("n", "<F29>", function()
    vim.notify("Debug Session Restarting", vim.diagnostic.severity.INFO)
    require("dap").terminate({}, { terminateDebuggee = true }, function()
      require("dap").run_last()
    end)
  end, { desc = "Continue/start a debug session" })
  set("n", "<F10>", "<cmd>DapStepOver<CR>", { desc = "DAP Step Over", })
  set("n", "<F11>", "<cmd>DapStepInto", { desc = "DAP Step Into", })
  set("n", "<F23>", "<cmd>DapStepOut<CR>", { desc = "DAP Step Out", })
  set("n", "<leader>b", "<cmd>DapToggleBreakpoint<CR>", { desc = "Toggle breakpoint on current line", })

  set("n", "<leader>do", function() require("dap.repl").toggle() end, { desc = "Toggle REPL", })
  set("n", "<leader>du", function() require("dapui"):toggle() end, { desc = "Toggle dapui", })
end

M.tabline = function()
  -- Why
  set("n", "<leader>x",
    function() require("config.ui.tabline.utils").close_buffer()
    end, { desc = "close buffer" })
  set("n", "<Tab>", function() require("config.ui.tabline.utils").next_buffer() end, { desc = "Next buffer" })
  set("n", "<S-Tab>", function() require("config.ui.tabline.utils").prev_buffer() end, { desc = "Prev buffer" })
end

M.comment = function()
  vim.keymap.set("n", "<C-/>", function()
    require("Comment.api").toggle.linewise.current()
  end, { desc = "toggle comment" })
  vim.keymap.set("x", "<C-/>", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
    { desc = "Toggle comment" })
  vim.keymap.set("n", "<leader>/", function()
    require("Comment.api").toggle.linewise.current()
  end, { desc = "toggle comment" })
  vim.keymap.set("x", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
    { desc = "Toggle comment" })
end

return M
