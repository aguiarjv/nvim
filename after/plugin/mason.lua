require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "pyright", "lua_ls", "emmet_ls", "cssls", "html", "tsserver", "gopls" },
})

-- Needs to install python3-venv to install python formatter and debugger
require("mason-tool-installer").setup({
	ensure_installed = { "black", "stylua", "debugpy", "prettier" },
})
