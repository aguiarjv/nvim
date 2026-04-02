local M = {}

function M.setup()
    local group = vim.api.nvim_create_augroup("CustomAutoCmds", { clear = true })

    require("checktime").setup(group)
    require("highlight_yank").setup(group)
end

return M
