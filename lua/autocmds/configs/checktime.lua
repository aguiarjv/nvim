local M = {}

function M.setup(main_group)
    local group = main_group or vim.api.nvim_create_augroup("CustomAutoCmds", { clear = true })

    vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
        group = group,
        command = "checktime", -- check if the file has been changed outside of Neovim and reload it
    })
end

return M
