if not vim.g.loaded_jdtls then
  vim.g.loaded_jdtls = true
  require("packer").loader("nvim-jdtls")
  require("packer").loader("nvim-dap")
end

local jdtls = require("jdtls")

local home = vim.env.HOME
local root_dir = vim.fs.dirname(vim.fs.find({ ".gradlew", ".git", "mvnw" }, { upward = true })[1])
local jdtls_path = home .. "/.local/share/nvim/mason/packages/jdtls"
local workspace_name = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
extendedClientCapabilities.progressReportProvider = true

local bundles = {
  vim.fn.glob(vim.fn.stdpath("data") ..
    "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar")
}
vim.list_extend(bundles,
  vim.split(vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/java-test/extension/server/*.jar"), "\n"))

local config = {}

config.root_dir = root_dir

config.cmd = {
  "/usr/lib/jvm/java-17-openjdk/bin/java",
  "-Declipse.applicaton=org.eclipse.jdt.ls.core.id1",
  "-Dosgi.bundles.defaultStartLevel=4",
  "-Declipse.product=org.eclipse.jdt.ls.core.product",
  "-Dlog.protocol=true",
  "-Dlog.level=ALL",
  "-Xmx4G",
  "--add-modules=ALL-SYSTEM",
  "--add-opens", "java.base/java.util=ALL-UNNAMED",
  "--add-opens", "java.base/java.lang=ALL-UNNAMED",
  "-jar", vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
  "-configuration", jdtls_path .. "/config_linux",
  "-data", workspace_name,
}

config.flags = {
  allow_incremental_sync = true,
}

config.init_options = {
  bundles = bundles,
  extendedClientCapabilities = extendedClientCapabilities,
}

config.capabilities = require("custom.plugins.lsp").set_capabilities()

config.settings = {
  java = {
    -- format = {
    --   settings = vim.env.HOME .. "/.config/jdtls/google_java_format.xml"
    -- },
    configuration = {
      runtimes = {
        {
          name = "JavaSE-11",
          path = "/usr/lib/jvm/java-11-openjdk/",
        },
        {
          name = "JavaSE-17",
          path = "/usr/lib/jvm/java-17-openjdk/",
        },
        {
          name = "JavaSE-19",
          path = "/usr/lib/jvm/java-19-openjdk/",
        }
      },
    },
    project = {
      referencedLibraries = {
        "/home/lucario387/Desktop/INIAD/Java/jar/gson-2.8.6.jar"
      },
    },
    signatureHelp = { enabled = true },
    contentProvider = { preferred = "fernflower" },
    completion = {
      favoriteStaticMembers = {
        "org.junit.Assert.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
      filteredTypes = {
        "com.sun.*",
        "io.micrometer.shaded.*",
        "java.awt.*",
        "jdk.*",
        "sun.*",
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
      },
      useBlocks = true
    },
  }
}

config.on_init = function(client, _)
  client.notify("workspace/didChangeConfiguration", { settings = config.settings })
end

config.on_attach = function(_, bufnr)
  require("core.utils").load_mappings("lspconfig", { buffer = bufnr })
  require("core.utils").load_mappings("jdtls", { buffer = bufnr })
  vim.keymap.set("n", "gi", function() require("jdtls").super_implementation() end, { buffer = bufnr })
  require("jdtls.dap").setup_dap({
    config_overrides = {
      noDebug = false,
    },
    hotcodereplace = "auto"
  })
  require("jdtls.setup").add_commands()
end
-- mute; having progress reports is enough
-- config.handlers = {
--   ["language/status"] = function() end,
--   ["$/progress"] = function() end,
--   ["window/showMessageRequest"] = function() end,
-- }
jdtls.start_or_attach(config)
