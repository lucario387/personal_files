local present, ts_config = pcall(require, "nvim-treesitter.configs")

if not present then
  return
end

-- Remember to do
-- npm i -g tree-sitter tree-sitter-cli beforehand
local default = {
  ensure_installed = {
    "c", "cpp", "c_sharp",
    "ocaml", "ocaml_interface", "ocamllex",
    "go", "gomod", "gowork", "godot_resource",
    "python",
    "bash",
    "markdown", "markdown_inline", "yaml", "regex",
    "vim",
    "lua",
    "make",
    "css", "scss", "html",
    "javascript", "typescript", "tsx",
    "json", "jsdoc", "json5", "jsonc",
    "dockerfile",
    "latex",
  },
  highlight = {
    enable = true,
    use_languagetree = true
  },
  indent = {
    enabled = true,
  },
  matchup = {
    enable = true,
    include_match_words = true,
    disable_virtual_text = true,
  },
  additional_vim_regex_highlighting = false,
}


local M = {}

M.setup = function()
  ts_config.setup(default)
end

return M
