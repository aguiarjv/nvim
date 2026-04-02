local M = {}

function M.setup()
    local group = vim.api.nvim_create_augroup("CustomAutoCmds", { clear = true })

    require("autocmds.configs.checktime").setup(group)
    require("autocmds.configs.highlight_yank").setup(group)
end

return M
