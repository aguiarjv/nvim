-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.

local home = os.getenv("HOME")

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = home .. "/.cache/jdtls/workspace" .. project_name

-- 💀
local path_to_mason_packages = home .. "/.local/share/nvim/mason/packages"
-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^

local path_to_jdtls = path_to_mason_packages .. "/jdtls"

local path_to_config = path_to_jdtls .. "/config_linux"
local lombok_path = path_to_jdtls .. "/lombok.jar"

-- 💀
local path_to_jar = path_to_jdtls .. "/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar"
local config = {
	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = {

		-- 💀
		"java", -- or '/path/to/java21_or_newer/bin/java'
		-- depends on if `java` is in your $PATH env variable and if it points to the right version.

		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",

		-- 💀
		"-jar",
		path_to_jar,
		-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
		-- Must point to the                                                     Change this to
		-- eclipse.jdt.ls installation                                           the actual version

		-- 💀
		"-configuration",
		path_to_config,
		-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
		-- Must point to the                      Change to one of `linux`, `win` or `mac`
		-- eclipse.jdt.ls installation            Depending on your system.

		-- 💀
		-- See `data directory configuration` section in the README
		"-data",
		workspace_dir,
	},

	-- 💀
	-- This is the default if not provided, you can remove it. Or adjust as needed.
	-- One dedicated LSP server & client will be started per unique root_dir
	--
	-- vim.fs.root requires Neovim 0.10.
	-- If you're using an earlier version, use: require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
	root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" }),

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {},
	},

	-- Language server `initializationOptions`
	-- You need to extend the `bundles` with paths to jar files
	-- if you want to use additional eclipse.jdt.ls plugins.
	--
	-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
	--
	-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
	init_options = {
		bundles = {},
	},
	capabilities = {
		workspace = {
			configuration = true,
		},
		textDocument = {
			completion = {
				completionItem = {
					snippentSupport = true,
				},
			},
		},
	},
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
config.capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
require("jdtls").start_or_attach(config)
