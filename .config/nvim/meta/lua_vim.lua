---@meta

vim.diagnostic = require("vim.diagnostic")
vim.filetype = require("vim.filetype")
vim.fs = require("vim.fs")
vim.ui = require("vim.ui")
vim.uri_from_bufnr = require("vim.uri").uri_from_bufnr
vim.uri_from_fname = require("vim.uri").uri_from_fname
vim.uri_to_bufnr = require("vim.uri").uri_to_bufnr
vim.uri_to_fname = require("vim.uri").uri_to_fname

---@type table<string, any>
vim.g = {}
