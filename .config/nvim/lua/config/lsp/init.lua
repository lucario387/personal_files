local M = {}

---register for null-ls
---@param sources table<any> list of sources to register
M.register = function(sources)
  local null = require("null-ls")
  for _, source in ipairs(sources) do
    if not null.is_registered(source) then
      null.register(source)
    end
  end
end

---use for both null ls and lspconfig
---@param client Client
---@param bufnr integer
M.on_attach = function(client, bufnr)
  -- Load LSP mappings for buffer bufnr
  require("mappings").lsp(bufnr)
end

---@return ClientCapabilities
M.set_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    -- tagSupport = { valueSet = { 1 } },
    resolveSupport = {
      properties = {
        -- "edit",
        "documentation",
        "detail",
        "additionalTextEdits",
      },
    },
  }
  return capabilities
end

M.lsp_handlers = function()
  local function lspSymbol(name, icon)
    local hl = "DiagnosticSign" .. name
    vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
  end

  lspSymbol("Warn", " ")
  lspSymbol("Info", " ")
  lspSymbol("Hint", " ")
  lspSymbol("Error", " ")

  vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,

    float = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "CursorMovedI", "InsertEnter", "FocusLost", "WinLeave" },
      border = "rounded",
      scope = "line",
    },
  })
  -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
end

return M
