if not package.loaded["jdtls"] then
	require("packer").loader("nvim-jdtls")
end

local jdtls = require("jdtls")

local home = os.getenv("HOME")
local root_dir = require("jdtls.setup").find_root({".git", "mvnw", "gradlew", "pom.xml"})

local jdtls_path = home .. "/.local/share/nvim/mason/packages/jdtls"
local workspace_name = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
local config = {}
config.root_dir = root_dir

config.cmd = {
	"java",
	"-Declipse.applicaton=org.eclipse.jdt.ls.core.id1",
	"-Dosgi.bundles.defaultStartLevel=4",
	"-Declipse.product=org.eclipse.jdt.ls.core.product",
	"-Dlog.protocol=true",
	"-Dlog.level=ALL",
	"-Xmx1g",
	"--add-modules=ALL-SYSTEM",
	"--add-opens", "java.base/java.util=ALL-UNNAMED",
	"--add-opens", "java.base/java.lang=ALL-UNNAMED",
	"-jar", vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
	"-configuration", jdtls_path .. "/config_linux",
	"-data", workspace_name,
}

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
config.init_options = {
	bundles = {},
	extendedClientCapabilities = extendedClientCapabilities,
}

config.on_attach = function(client, bufnr)
	require("config.lsp.utils").set_mappings()
	print("WOke")
end


jdtls.start_or_attach(config)
