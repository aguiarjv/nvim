local M = {}

function M.setup(group_name)
    local group = vim.api.nvim_create_augroup(group_name or "CustomAutoCmds", { clear = true })

    vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
        group = group,
        command = "checktime", -- check if the file has been changed outside of Neovim and reload it
    })
end

return M
