local opt = vim.opt
local g = vim.g
local fn = vim.fn
-- General settings
opt.laststatus = 3 -- Global statusline
opt.termguicolors = true
opt.updatetime = 250
opt.timeoutlen = 400
opt.undofile = true -- Allow to undo to states before opening

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
opt.sessionoptions = "buffers,curdir,folds,winpos,winsize,tabpages"
-- Wrap, linebreak settings
opt.wrap = true
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

opt.mouse = "a"

opt.whichwrap:append "<>[]hl"
g.mapleader = " "

if fn.exists("$VIRTUAL_ENV") == 1 then
	g.python3_host_prog = fn.substitute(fn.system(                                    "which -a python3 | head -n2 | tail -n1")
	                                    , "\n", "", "g")
else
	g.python3_host_prog = fn.substitute(fn.system(                                    "which python3"), "\n", "", "g")
end

-- add PATH for lsp/dap/null-ls etc
vim.env.PATH = vim.env.PATH .. ":" .. (fn.stdpath("data") .. "/mason/bin")

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
