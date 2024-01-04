require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "pyright", "pylsp", "lua_ls", "emmet_ls", "cssls", "tailwindcss", "html", "tsserver", "gopls" },
})

-- Needs to install python3-venv to install python formatter and debugger
require("mason-tool-installer").setup({
	ensure_installed = { "black", "stylua", "debugpy", "prettier", "flake8", "eslint_d" },
})
