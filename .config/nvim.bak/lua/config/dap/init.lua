local M = {}

-- local fn = vim.fn
-- local sign_define = fn.sign_define

local adapters = require("config.dap.adapters")
local configurations = require("config.dap.configs")


M.load_vscode_config = function()
	require("dap.ext.vscode").load_launchjs(nil, {
		cppdbg = { "c", "cpp" },
	})
end

M.setup = function()
	local dap, repl = require("dap"), require("dap.repl")

	-- nvim-dap settings
	vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "", })
	vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "Error", linehl = "", numhl = "", })
	vim.fn.sign_define("DapStopped", { text = "⭐️", texthl = "", })
	-- dap.defaults.fallback.terminal_win_cmd = "10split new"
	-- dap.defaults.fallback.focus_terminal = true
	for key, value in pairs(adapters) do
		dap.adapters[key] = value
	end
	for filetype, config in pairs(configurations) do
		dap.configurations[filetype] = config
	end
	-- M.load_vscode_config()
	-- dap-repl settings
	repl.commands = vim.tbl_deep_extend("force", repl.commands, {
		exit = { "exit", ".exit", ".bye" },
	})
end


return M
