-- Unsure if this is nice or not, but why not
local fn = vim.fn
-- local config = require("core.utils").load_config()
vim.g.vim_version = vim.version().minor
vim.g.nvchad_theme = "vscode_dark"
vim.g.transparency = false
vim.g.nvimtree_side = "left"
-- g.theme_switcher_loaded = false
-- opt.cmdheight = 0
vim.o.laststatus = 3 -- global statusline
vim.o.showmode = false

-- o.title = true
-- o.clipboard = "unnamedplus"
vim.o.cursorline = true
vim.o.exrc = true

-- Indenting
vim.o.expandtab = true
vim.o.shiftwidth = 2
-- o.smartindent = true
vim.o.tabstop = 2
vim.o.softtabstop = 2

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes"
-- vim.o.mouse = ""


vim.o.splitbelow = true
vim.o.splitright = true
vim.o.termguicolors = true
vim.o.timeoutlen = 400
vim.o.undofile = true
vim.o.swapfile = true
vim.o.history = 100

-- interval for writing swap file to disk, also used by gitsigns
vim.o.updatetime = 2000

-- vim.opt.smartindent = true
vim.o.number = true
vim.o.numberwidth = 2
vim.o.ruler = false
vim.o.relativenumber = true
-- o.shadafile = "NONE"
vim.o.conceallevel = 2
vim.o.concealcursor = "nv"
-- o.sessionoptions = "buffers,curdir,localoptions,folds,help,winpos,tabpages"
vim.o.expandtab = true
-- Wrap, linebreak settings
-- o.scrolloff = 25
vim.o.wrap = true
vim.o.linebreak = true
vim.o.breakindent = true
-- o.cmdheight = 0
vim.o.timeoutlen = 250

vim.o.pumheight = 5
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldenable = false
-- o.spell = true

vim.g.loaded_jdtls = false
-- vim.g.loaded_clangd = false
vim.g.matchup_matchparen_offscreen = { method = nil, scrolloff = 1 }
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- disable nvim intro
vim.opt.shortmess:append "sIcC"
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.diffopt = { "internal", "filler", "closeoff", "linematch:90" }
-- others: !,'100,<50,s10,h)
vim.opt.shada = { "!", "'0", "/0", "<0", "@0", "f0", "h", "s0" }
vim.opt.fillchars = { eob = " " }
-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
vim.opt.whichwrap:append "<>[]hl"
-- remove some format options


-- Managing python files
if fn.exists("$VIRTUAL_ENV") == 1 then
  vim.g.python3_host_prog = fn.substitute(fn.system("which -a python3 | head -n2 | tail -n1"), "\n", "", "g")
else
  vim.g.python3_host_prog = fn.substitute(fn.system("which python3"), "\n", "", "g")
end

local disabled_plugins = {
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
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "tutor",
  "rplugin",
  "syntax",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  "ftplugin",
  "matchparen",
  "fzf",
}

for _, plugin in pairs(disabled_plugins) do
  vim.g["loaded_" .. plugin] = 1
end


local disabled_providers = {
  -- "node_provider",
  "perl_provider",
  -- "python3_provider",
  "ruby_provider",
}
for _, provider in pairs(disabled_providers) do
  vim.g["loaded_" .. provider] = 0
end

vim.filetype.add({
  extension = {
    rasi = "rasi",
    astro = "astro",
    json = "jsonc",
    ebnf = "ebnf",
  },
  filename = {
    [".clangd"] = "yaml",
    -- [".ideavimrc"] = "vim",
    ["sxhkdrc"] = "sxhkdrc",
  },
  pattern = {
    ["${XDG_CONFIG_HOME:$HOME/.config}/fd/ignore"] = "gitignore",
  },
})
-- require("custom.autocmd")
require("custom.ui")
