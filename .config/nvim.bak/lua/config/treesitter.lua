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
		"jsonc",
		"dockerfile",
		"latex",
	},
	highlight = {
		enable = true,
		use_languagetree = true,
	},
	-- indent = {
	-- 	enable = true,
	-- },
	matchup = {
		enable = true,
		include_match_words = true,
		disable_virtual_text = false,
	},
	-- autotag = {
	-- 	enable = true,
	-- },
	additional_vim_regex_highlighting = false,
}

vim.filetype.add({
	extension = {
		rasi = "rasi",
	}
})

ts_config.setup(default)
