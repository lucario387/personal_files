-- local autocmd = vim.api.nvim_create_autocmd
-- local augroup = vim.api.nvim_create_augroup
-- Ibus manip
-- local ibus_insert_mode = nil
-- local ibus_other_modes = "xkb:us::eng"
--
-- local ibus_group = augroup("Ibus Switching", { clear = true })
--
-- autocmd("InsertEnter", {
-- 	group = ibus_group,
-- 	pattern = { "*.md", "*.tex" },
-- 	callback = function()
-- 		if ibus_insert_mode == nil then
-- 			return
-- 		else
-- 			os.execute("ibus engine " .. ibus_insert_mode)
-- 		end
-- 	end
-- })
--
-- autocmd("InsertLeave", {
-- 	group = ibus_group,
-- 	pattern = { "*.md", "*.tex" },
-- 	callback = function()
-- 		local f = assert(io.popen("ibus engine", "r"))
-- 		ibus_insert_mode = f:read("*a")
-- 		f:close()
-- 		os.execute("ibus engine " .. ibus_other_modes)
-- 	end
-- })
--

-- autocmd("FileType", {
--   pattern = { "dap-repl" },
--   callback = function()
--     vim.bo.buflisted = false
--   end
-- })

vim.api.nvim_create_autocmd("VimEnter", {
  -- once = true,
  callback = function()
    vim.cmd("clearjumps")
  end
})
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.cmd "startinsert"
  end,
  pattern = "term://*",
})

vim.api.nvim_create_autocmd({ "BufLeave" }, {
  callback = function()
    vim.cmd "stopinsert"
  end,
  pattern = "term://*",
})
-- local max_filesize = 100 * 1024
--Disable treesitter + LSP for large files
--Its slow as fuck
-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--   callback = function(args)
--     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
--     if ok and stats and stats.size > max_filesize then
--       -- vim.lsp.buf_detach_client(args.buf)
--       vim.treesitter.stop(args.buf)
--     end
--   end
-- })

-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   callback = function(args)
--     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
--     if ok and stats and stats.size > max_filesize then
--       vim.treesitter.stop(args.buf)
--     end
--   end
-- })

