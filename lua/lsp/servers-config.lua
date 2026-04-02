return {
    bashls = true,
    pyright = true,
    ruff = { manual_install = true },
    lua_ls = require("lsp.configs.lua_ls"),
    jsonls = require("lsp.configs.jsonls"),
    clangd = require("lsp.configs.clangd"),
    eslint = require("lsp.configs.eslint"),
    vtsls = require("lsp.configs.vtsls"),
    tailwindcss = require("lsp.configs.tailwindcss"),
    jdtls = {}, -- mason will install jdtls but vim.lsp won't use it
}
