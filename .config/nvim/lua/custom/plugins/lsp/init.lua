local M = {}

---register for null-ls
---@param sources table<any> list of sources to register
M.register = function(sources)
  for _, source in ipairs(sources) do
    if not require("null-ls").is_registered(source) then
      require("null-ls").register(source)
    end
  end
end

---use for both null ls and lspconfig
---@param client table
---@param bufnr integer
M.on_attach = function(client, bufnr)
  -- Load LSP mappings for buffer bufnr
  require("core.utils").load_mappings("lspconfig", { buffer = bufnr })

  -- Autoformat
  -- if client.supports_method("textDocument/formatting") then
  --   vim.api.nvim_create_autocmd("BufWritePre", {
  --     buffer = bufnr,
  --     callback = function()
  --       vim.lsp.buf.format({
  --         -- formatting_options = {
  --         --   trimTrailingWhitespace = true,
  --         -- },
  --         bufnr = bufnr,
  --       })
  --     end
  --   })
  -- end
  -- local augroup = vim.api.nvim_create_augroup("LSPAutoFormat", {clear = false})
  -- vim.api.nvim_clear_autocmds({group = augroup})
  -- vim.api.nvim_create_autocmd("BufWritePre", {
  --   group = augroup,
  --   callback = function()
  --     vim.lsp.buf.format({
  --       bufnr = bufnr,
  --     })
  --   end
  -- })
end

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
    tagSupport = { valueSet = { 1 } },
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
  lspSymbol("Hint", "")
  lspSymbol("Error", " ")

  vim.diagnostic.config {
    virtual_text     = false,
    signs            = true,
    underline        = true,
    update_in_insert = false,
    severity_sort    = true,

    float = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "CursorMovedI", "InsertEnter", "FocusLost", "WinLeave" },
      border = "rounded",
      scope = "line",
    },
  }
  -- vim.notify = function(msg, log_level)
  --   if msg:match "exit code" then
  --     return
  --   end
  --   if log_level == vim.log.levels.ERROR then
  --     vim.api.nvim_err_writeln(msg)
  --   else
  --     vim.api.nvim_echo({ { msg } }, true, {})
  --   end
  -- end
end

return M
