return {
    bashls = true,
    pyright = true,
    ruff = { manual_install = true },
    lua_ls = require("lsp.configs.lua_ls"),
    jsonls = require("lsp.configs.jsonls"),
    clangd = require("lsp.configs.clangd"),
    vtsls = require("lsp.configs.vtsls"),
    tailwindcss = require("lsp.configs.tailwindcss"),
}
