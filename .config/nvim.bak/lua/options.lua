local opt = vim.opt
local g = vim.g
local fn = vim.fn
-- General settings
opt.laststatus = 3 -- Global statusline
opt.cmdheight = 0 -- Hide cmdheight unless in command mode
opt.termguicolors = true
opt.updatetime = 250
opt.timeoutlen = 400
opt.undofile = true -- Allow to undo to states before opening
-- Colorscheme color
g.catppuccin_flavour = "frappe"
g.matchup_matchparen_offscreen = { method = nil, scrolloff = 1 }
g.cursorhold_updatetime = 100

-- Tab settings
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = false
opt.smartindent = true

-- disable tilde on end of buffer
opt.fillchars = {
	eob = " "
}
opt.title = true
opt.clipboard = "unnamedplus"

-- Search settings
opt.ignorecase = true
opt.smartcase = true

-- Disable intro
opt.shortmess:append("sI")
opt.showmode = false

-- Session settings
opt.sessionoptions = "buffers,curdir,folds,winpos,tabpages"
-- Wrap, linebreak settings
opt.wrap = false
opt.linebreak = true
opt.breakindent = true

-- Folding settings
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldminlines = 5

-- Splits managing
opt.signcolumn = "yes:1"
opt.splitright = true
opt.splitbelow = true

-- Numbers!
opt.number = true
opt.ruler = false

-- Mouse even tho 99% of the time i wont use it inside vim
opt.mouse = "a"

opt.whichwrap:append "<>[]hl"
g.mapleader = " "

-- So that I can know if Im using spaces or tabs
-- opt.list = true
-- opt.listchars = "tab: ,lead:⋅,trail:⋅,eol:↴"
-- get python path
if fn.exists("$VIRTUAL_ENV") == 1 then
	g.python3_host_prog = fn.substitute(fn.system("which -a python3 | head -n2 | tail -n1"), "\n", "", "g")
else
	g.python3_host_prog = fn.substitute(fn.system("which python3"), "\n", "", "g")
end

-- add mason to PATH for lsp/dap/null-ls usage if mason is not started on startup
-- vim.env.PATH = (fn.stdpath("data") .. "/mason/bin" .. ":") .. vim.env.PATH

local disabled_built_ins = {
	"2html_plugin",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"matchit",
	"matchparen",
	"tar",
	"tarPlugin",
	"tutor",
	"rrhelper",
	"spellfile_plugin",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
	"rplugin",
	"syntax",
	"synmenu",
	"fzf",
	"compiler",
	"bugreport",
	-- "ftplugin"
}

for _, plugin in pairs(disabled_built_ins) do
	g["loaded_" .. plugin] = 1
end

local disabled_providers = {
	"ruby_provider",
	"perl_provider",
}

for _, provider in pairs(disabled_providers) do
	g["loaded_" .. provider] = 0
end
