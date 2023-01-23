---@meta


vim.lsp = require("vim.lsp")
---@meta
---@diagnostic disable: codestyle-check

---Value-object describing what options formatting should use
---    - [string]: string|integer|boolean : Signature for further properties defined by the language server
---@alias FormattingOptions {tabSize: integer, insertSpaces: boolean, trimTrailingWhitespace?: boolean, insertFinalNewLines?: boolean, trimFinalNewLine?: boolean, [string]: string|integer|boolean}

---@class Client : Object
---@field id integer The id allocated to the client
---@field name string Name for the client
---@field rpc RpcClient RPC client object
---@field offset_encoding string
---@field handlers LSPHandlers[]
---@field requests LSPRequest[]
---@field config table Copy of the table that was passed by the user to `vim.lsp.start_client()`
---@field server_capabilities ClientCapabilities
---@field request fun(method, params, handler?, bufnr)
---@field request_sync fun(method, params, timeout_ms, bufnr)
---@field notify fun(method, params)
---@field cancel_request fun(id)
---@field stop fun(force: boolean?)
---@field is_stopped fun(): boolean
---@field on_attach fun(client: Client, bufnr: integer)

---@class VimLSPFormat : Object
---@field formatting_options FormattingOptions
---@field timeout_ms integer|1000
---@field bufnr integer|nil
---@field filter fun(client: Client): boolean
---@field async boolean?
---@field id integer?
---@field name string?
---@field range TSRange?

---@param options VimLSPFormat
function vim.lsp.buf.format(options) end

---@return ClientCapabilities
function vim.lsp.protocol.make_client_capabilities() end
