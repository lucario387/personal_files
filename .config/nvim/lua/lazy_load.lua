local M = {}

local autocmd = vim.api.nvim_create_autocmd

M.bufferline = function()
  -- Only load bufferline when there's more than 2 listed buffers
  autocmd({ "BufNewFile", "BufRead", "TabEnter" }, {
    group = vim.api.nvim_create_augroup("BufferLineLazyLoad", {}),
    callback = function()
      if #vim.fn.getbufinfo({ buflisted = 1 }) >= 2 then
        lazy("bufferline.nvim")
        vim.api.nvim_del_augroup_by_name("BufferLineLazyLoad")
      end
    end,
  })
end

M.statusline = function()
  -- Lazy load feline
  autocmd({ "VimEnter" }, {
    once = true,
    callback = function()
      lazy("feline.nvim")
    end
  })
end

M.matchup = function()
  -- Lazy load treesitter related plugin after treesitter
  autocmd({ "BufReadPre", "BufNewFile" }, {
    once = true,
    callback = function()
      lazy("vim-matchup")
    end,
  })
end

M.blankline = function()
  autocmd({ "BufReadPre", "BufNewFile" }, {
    once = true,
    callback = function()
      lazy("indent-blankline.nvim")
    end,
  })
end

M.mason = function()
  autocmd({ "VimEnter" }, {
    once = true,
    callback = function()
      lazy("mason.nvim")
    end
  })
end

M.mason_lsp = function()
  autocmd({ "VimEnter" }, {
    once = true,
    callback = function()
      lazy("mason-lspconfig.nvim")
    end,
  })
end

M.lsp = function()
  -- Load lsp-installer after treesitter
  autocmd({ "UIEnter", }, {
    once = true,
    callback = function()
      lazy("nvim-lspconfig")
    end,
  })
end

M.theme = function()
  autocmd({ "VimEnter" }, {
    once = true,
    callback = function()
      lazy("theme")
    end,
  })
end

M.gitsigns = function()
  autocmd({ "BufRead" }, {
    callback = function()
      local function onexit(code, _)
        if code == 0 then
          vim.schedule(function()
            require("packer").loader "gitsigns.nvim"
          end)
        end
      end

      local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      if lines ~= { "" } then
        vim.loop.spawn("git", {
          args = {
            "ls-files",
            "--error-unmatch",
            vim.fn.expand "%:p:h",
          },
        }, onexit)
      end
    end,
  })
end
return M
