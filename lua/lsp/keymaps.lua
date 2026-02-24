local M = {}

local fzf_lua = require("fzf-lua")

function M.on_attach(client, bufnr)
    vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

    vim.keymap.set("n", "gd", fzf_lua.lsp_definitions, { desc = "Go to definition", buffer = bufnr })
    vim.keymap.set("n", "gr", fzf_lua.lsp_references, { desc = "Go to references", buffer = bufnr })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration", buffer = bufnr })
    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { desc = "Go to type definition", buffer = bufnr })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover", buffer = bufnr })

    vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { desc = "Rename", buffer = bufnr })
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { desc = "Code action", buffer = bufnr })
    vim.keymap.set("n", "<space>ww", fzf_lua.lsp_document_symbols, { buffer = bufnr })
    vim.keymap.set("n", "<space>wd", function()
        fzf_lua.diagnostics_document({ root_dir = true })
    end, { desc = "Diagnostics document", buffer = bufnr })
end

return M
