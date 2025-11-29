return {
    bashls = true,
    pyright = true,
    ruff = { manual_install = true },
    lua_ls = require("lsp.lua_ls"),
    jsonls = require("lsp.jsonls"),
    clangd = require("lsp.clangd"),
    vtsls = require("lsp.vtsls"),
    tailwindcss = require("lsp.tailwindcss"),
}
