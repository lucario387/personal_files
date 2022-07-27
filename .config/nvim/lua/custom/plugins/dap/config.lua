local M = {}
M.cpp = {
  {
    name = "Launch Current File",
    type = "cppdbg",
    request = "launch",
    program = function()
      -- :h input
      return vim.fn.input("Path to executable: ", vim.fn.expand("%:r"), "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = true,
    setupCommands = {
      {
        description = "デバッグ開始",
        text = "-enable-pretty-printing",
        ignoreFailures = false,
      },
    },
  },
  {
    name = "Launch debug in current cwd",
    type = "cppdbg",
    request = "launch",
    program = function()
      -- :h input
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    setupCommands = {
      {
        description = "デバッグ開始",
        text = "-enable-pretty-printing",
        ignoreFailures = false,
      },
    },
  }
  -- {
  -- 	name = "Attach to gdbserver"
  -- }

}

M.c = M.cpp

M.java = {

}

return M
