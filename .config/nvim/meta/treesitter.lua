---@meta
---@diagnostic disable: codestyle-check

vim.treesitter = require("vim.treesitter")
vim.treesitter.highlighter = require("vim.treesitter.highlighter")
vim.treesitter.query = require("vim.treesitter.query")
vim.treesitter.language = require("vim.treesitter.language")
---@class TSNode : Object
---@field __eq fun(): boolean
---@field __len fun(): integer
---@field id fun(): string Unique string
---@field range fun(): integer, integer, integer, integer
---@field start fun(): integer, integer, integer
---@field end_ fun(): integer, integer, integer
---@field type fun(): string Node's type as a string
---@field symbol fun(): integer Node's type as a numerical id
---@field field fun(name: string): table
---@field named fun(): boolean
---@field missing fun(): boolean check if the node is missing
---@field has_error fun(): boolean check if the node is/contains syntax error
---@field sexpr fun(): string
---@field child_count fun(): integer
---@field named_child_count fun(): integer
---@field child fun(index: integer): TSNode
---@field named_child fun(index: integer): TSNode
---@field descendant_for_range fun(start_row: integer, start_col: integer, end_row: integer, end_col: integer): TSNode the smallest node within this node that spans the given range of (row, column)
---@field named_descendant_for_range fun(start_row: integer, start_col: integer, end_row: integer, end_col: integer): TSNode the smallest named node within this node that spans the given range of (row, column)
---@field parent fun(): TSNode
---@field iter_children fun()
---@field _rawquery fun()
---@field next_sibling fun(): TSNode
---@field prev_sibling fun(): TSNode
---@field next_named_sibling fun(): TSNode
---@field prev_named_sibling fun(): TSNode
---@field named_children fun(): TSNode[] all named_chiled
---@field root fun(): TSNode return root node containing this node
---@field byte_length fun(): integer

---@class Capture
---@field capture string
---@field metadata table<string, any>

---TSRange {[1]: integer, [2]: integer, [3]: integer, [4]: integer}
---@class TSRange
---@field [1] integer start_row
---@field [2] integer start_col
---@field [3] integer end_row
---@field [4] integer end_col

---@class TSPlaygroundTree
---@field lang string? The language of the source buffer
---@field bufnr integer? Buffer to draw the tree into
---@field winid integer? Window id to display the tree buffer in
---@field command string Vimscript command to create the window
---@field title string|(fun(bufnr: number):string|nil) Title of the window

---Returns a list of highlight capture names under the cursor
---@param winnr number? Window handle or 0 for current window
---@return string[] captures List of capture names
function vim.treesitter.get_captures_at_cursor(winnr) end

---Returns a list of highlight captures at the given position
---@param bufnr number Buffer number
---@param row number Position row
---@param col number Position column
---@return Capture[]
function vim.treesitter.get_captures_at_pos(bufnr, row, col) end

---Returns the smallest named node under the cursor
---@param winnr number? Window handle or 0 for current window -@return TSNode node Name of node under the cursor
function vim.treesitter.get_node_at_cursor(winnr) end

---Returns the smallest named node at the given position
---@param bufnr number Buffer number
---@param row number Position row
---@param col number Position column
---@param opts {lang: string|nil, ignore_injections: boolean} Optional keyword arguments
function vim.treesitter.get_node_at_pos(bufnr, row, col, opts) end

---Returns the node's range or an unpacked range table
---@param node_or_range (TSNode|TSRange) Node
---@return integer start_row
---@return integer start_col
---@return integer end_row
---@return integer end_col
function vim.treesitter.get_node_range(node_or_range) end

---Returns the parser for a specific buffer and filetype and attaches it to the buffer
---@param bufnr number|nil Buffer the parser should be tied to (Default to current buffer)
---@param lang string|nil Filetype of this parser (Defaults to buffer filetype)
---@param opts table|nil options to pass to the created language tree
---@return LanguageTree
function vim.treesitter.get_parser(bufnr, lang, opts) end

---Returns the parser for a specific buffer and filetype and attaches it to the buffer
---@param str string Buffer the parser should be tied to (Default to current buffer)
---@param lang string Filetype of this parser (Defaults to buffer filetype)
---@param opts table|nil options to pass to the created language tree
---@return LanguageTree
function vim.treesitter.get_string_parser(str, lang, opts) end

---Determines whether a node is the ancestor of another
---@param dest TSNode possible ancestor
---@param source TSNode possible descendant
---@return boolean boolean # whether `dest` is an ancestor of `source`
function vim.treesitter.is_ancestor(dest, source) end

---Determines whether (line, col) position is in node range
---@param node TSNode
---@param line integer
---@param col integer
---@return boolean
function vim.treesitter.is_in_node_range(node, line, col) end

---Determines if a node contains a range
---@param node TSNode
---@param range TSRange
---@return boolean
function vim.treesitter.node_contains(node, range) end

---Open a window that displays a textual representation of the nodes in the language tree.
---@param opts TSPlaygroundTree
function vim.treesitter.show_tree(opts) end

---Starts treesitter highlighting for buffer `bufnr` with parser `lang`
---@param bufnr integer?
---@param lang string?
function vim.treesitter.start(bufnr, lang) end

---Stop treesitter highlighting for buffer `bufnr`
---@param bufnr integer?
function vim.treesitter.stop(bufnr) end

---Adds a new directive to be used in queries
---
---Handlers can set match level data by setting directly on the metadata
---object `metadata.key = value`, additionally, handlers can set node level
---data by using the capture id on the metadata table
---`metadata[capture_id].key = value`
---@param name string Name of the directive, without leading `#`
---@param handler fun(match: string, pattern: string, bufnr: integer, predicate: fun(), metadata:table)
function vim.treesitter.query.add_directive(name, handler, force) end

---Add a new predicate to be used in queries
---@param name string Name of the directive, without leading `#`
---@param handler fun(match: string, pattern: string, bufnr: integer, predicate: fun(), metadata:table)
function vim.treesitter.query.add_predicate(name, handler, force) end

---Gets the text corresponding to a given node
---@param node TSNode
---@param source integer|string Buffer or string from which the `node` is extracted
---@param opts {concat: boolean} Concatenate result in a string
---@return string[]|string
function vim.treesitter.query.get_node_text(node, source, opts) end

---Returns the runtime query `query_name` for `lang`.
---@param lang string language to use for the query
---@param query_name string name of the query (for example: `highlights`)
---@return Query # Parsed query
function vim.treesitter.query.get_query(lang, query_name) end

---Gets the list of files used to make up a query
---@param lang string Language to get query for
---@param query_name string Name of the query to load
---@param is_included boolean? Internal parameter, most of the time left as `nil`
function vim.treesitter.query.get_query_files(lang, query_name, is_included) end

---Lists the currently available directives to use in queries
---@return string[] directives list of supported directives
function vim.treesitter.query.list_directives() end

---Lists the currently available predicates to use in queries
---@return string[] predicates list of supported predicates
function vim.treesitter.query.list_predicates() end

---Parse `query` as a string
---@param lang string Language to use for the query
---@param query string Query in `s-expr syntax`
---@return Query
function vim.treesitter.query.parse_query(lang, query) end

---Sets the runtime query named `query_name` for `lang`
---@param lang string Language to use for the query
---@param query_name string Name of the query
---@param text string Query text
function vim.treesitter.query.set_query(lang, query_name, text) end

---A [LanguageTree]() holds the treesitter parser for a given language `Lang`
---used to parse a buffer. As the buffer may contain injected languages, the LanguageTree needs to store parsers for these child languages as well (which in turn
---may contain child languages themselves, hence the name).
---@param source integer|string Buffer or a string of text to parse
---@param lang string Root language this tree represents
---@param opts {injections: table}|nil
function vim.treesitter.languagetree.new(source, lang, opts) end
