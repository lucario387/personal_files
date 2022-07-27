local jdtls = require("jdtls")
local lspconfig = require("lspconfig")

local home = os.getenv("HOME")
local root_dir = require("jdtls.setup").find_root({".git", "mvnw", "gradlew", "pom.xml"})

local tmp = "/home/lucario387/.local/share/nvim/mason/packages/jdtls"
local jdtls_path = home .. "/.local/share/nvim/mason/packages/jdtls"
local workspace_name = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
local config = {}

config.cmd = {
	"java",
	"-Declipse.applicaton=org.eclipse.jdt.ls.core.id1",
	"-Dosgi.bundles.defaultStartLevel=4",
	"-Declipse.product=org.eclipse.jdt.ls.core.product",
	"-Dlog.protocol=true",
	"-Dlog.level=ALL",
	"-Xms1g",
	"--add-modules=ALL-SYSTEM",
	"--add-opens", "java.base/java.util=ALL-UNNAMED",
	"--add-opens", "java.base/java.lang=ALL-UNNAMED",
	"-jar", vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher*.jar"),
	"-configuration", jdtls_path .. "/config_linux",
	"-data", workspace_name,
}


jdtls.start_or_attach(config)
