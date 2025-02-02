return {
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "stylua",
                "shellcheck",
                "shfmt",
                "eslint_d",
                "prettier",
                "css-lsp",
                "emmet-ls",
                "gopls",
                "html-lsp",
                "jdtls",
                "lua-language-server",
                "tailwindcss-language-server",
                "typescript-language-server",
            },
        },
    },
}
