local lspconfig = require("lspconfig")
local lsputil = require("lspconfig.util")
local config = require("lspconfig.configs")

local on_attach = require("config.lsp").on_attach
local capabilities = require("config.lsp").set_capabilities()

local bin_name = "pylance-langserver"
local cmd = { bin_name, "--stdio" }
-- client.server_capabilities.executeCommandProvider
local _commands = {
  "pyright.createtypestub",
  "pyright.organizeimports",
  "pyright.addoptionalforparam",
  "python.createTypeStub",
  "python.orderImports",
  "python.addOptionalForParam",
  "python.removeUnusedImport",
  "python.addImport",
  "python.intellicode.completionItemSelected",
  "python.intellicode.loadLanguageServerExtension",
  "pylance.extractMethod",
  "pylance.extractVariable",
  "pylance.dumpFileDebugInfo",
  "pylance.completionAccepted",
  "pylance.executedClientCommand",
}

local function organize_imports()
  local params = {
    command = "pyright.organizeimports",
    arguments = { vim.uri_from_bufnr(0) },
  }
  vim.lsp.buf.execute_command(params)
end

-- local function create_typestub()
--   local params = {
--     command = ""
--   }
--   vim.lsp.buf.execute_command(params)
-- end

local function extract_variable()
  local pos_params = vim.lsp.util.make_given_range_params()
  local params = {
    command = "pylance.extractVariable",
    arguments = {
      vim.api.nvim_buf_get_name(0),
      pos_params.range,
    },
  }
  vim.lsp.buf.execute_command(params)
  -- vim.lsp.buf.rename()
end

local function extract_method()
  local pos_params = vim.lsp.util.make_given_range_params()
  local params = {
    command = "pylance.extractMethod",
    arguments = {
      vim.api.nvim_buf_get_name(0),
      pos_params.range,
    },
  }
  vim.lsp.buf.execute_command(params)
  -- vim.lsp.buf.rename()
end

local function get_python_interpreters(a, l, p)
  local paths = {}
  -- local is_home_dir = function()
  --   return vim.fn.getcwd(0) == vim.fn.expand("$HOME")
  -- end
  local find_paths = {
    vim.env.HOME .. "/anaconda3/envs/*/bin",
    vim.env.HOME .. "/venvs",
  }
  for _, find_path in ipairs(find_paths) do
    local _paths = vim.fn.executable("fd") and vim.fn.systemlist("fd -c never -g python " .. find_path)
      or vim.fn.systemlist("find find_path -name python")
    if vim.v.shell_error == 0 and _paths then
      for _, path in ipairs(_paths) do
        table.insert(paths, path)
      end
    end
  end
  table.sort(paths)
  local res = {}
  for i, path in ipairs(paths) do
    if path ~= paths[i + 1] then
      table.insert(res, path)
    end
  end
  if a then
    for _, p in ipairs(res) do
      if not string.find(p, a) then
        res = vim.fn.getcompletion(a, "file")
      end
    end
  end
  return res
end

local function change_python_interpreter(path)
  local client = lsputil.get_active_client_by_name(0, "pylance")
  client.stop()
  -- local config = require("lspconfig.server_configurations.pylance")
  -- config.settings.python.pythonPath = path
  lspconfig.pylance.setup({
    settings = {
      python = {
        pythonPath = path,
        analysis = {
          indexing = true,
          typeCheckingMode = "basic",
          diagnosticMode = "workspace",
          stubPath = vim.env.HOME .. "/typings",
          diagnosticSeverityOverrides = {
            reportMissingTypeStubs = "none",
          },
        },
      },
    },
  })
  vim.cmd("LspStart pylance")
end

if not config.pylance then
  config.pylance = {
    default_config = {
      cmd = cmd,
      name = "pylance",
      autostart = true,
      single_file_support = true,

      -- "node",
      -- vim.fn.expand("~/.vscode/extensions/ms-python.vscode-pylance-*/dist/server.bundle.crack.js", false, true)[1],
      -- "--stdio",
      filetypes = { "python" },
      root_dir = function(fname)
        local markers = {
          "Pipfile",
          "pyproject.toml",
          "pyrightconfig.json",
          "setup.py",
          "setup.cfg",
          "requirements.txt",
        }
        return lsputil.root_pattern(unpack(markers))(fname)
          or lsputil.find_git_ancestor(fname)
          or lsputil.path.dirname(fname)
      end,
      on_attach = function(client, bufnr)
        client.commands["pylance.extractVariableWithRename"] = function(command, enriched_ctx)
          command.command = "pylance.extractVariable"
          vim.lsp.buf.execute_command(command)
        end
        client.commands["pylance.extractMethodWithRename"] = function(command, enriched_ctx)
          command.command = "pylance.extractMethod"
          vim.lsp.buf.execute_command(command)
        end
        vim.api.nvim_buf_create_user_command(0, "PythonInterpreter", function(opt)
          change_python_interpreter(opt.args)
        end, { nargs = 1, complete = get_python_interpreters })
        vim.api.nvim_buf_create_user_command(
          0,
          "PylanceOrganizeImports",
          organize_imports,
          { desc = "Organize Imports" }
        )
        vim.api.nvim_buf_create_user_command(0, "PylanceExtractVariable", extract_variable, {
          range = true,
          desc = "Extract variable",
        })
        vim.api.nvim_buf_create_user_command(0, "PylanceExtractMethod", extract_method, {
          range = true,
          desc = "Extract method",
        })
        require("config.lsp").register({
          require("null-ls").builtins.formatting.autopep8,
        })
        on_attach(client, bufnr)
      end,
      capabilities = capabilities,
      settings = {
        python = {
          telemetry = {
            telemetryLevel = "off",
          },
          analysis = {
            indexing = true,
            typeCheckingMode = "basic",
            diagnosticMode = "workspace",
            stubPath = vim.env.HOME .. "/typings",
            diagnosticSeverityOverrides = {
              reportMissingTypeStubs = "none",
            },
          },
        },
      },
      docs = {
        package_json = vim.fn.expand("$HOME/.vscode/extensions/ms-python.vscode-pylance-*/package.json", false, true)[1],
        description = [[
          https://github.com/microsoft/pyright
          `pyright`, a static type checker and language server for python
        ]],
      },
      -- before_init = function(_, config)
      --     if not config.settings.python then
      --         config.settings.python = {}
      --     end
      --     if not config.settings.python.pythonPath then
      --         config.settings.python.pythonPath = "/Users/laurenzi/venvs/base/bin/python"
      --     end
      -- end,
    },
  }
end
