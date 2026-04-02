local M = {}

function M.setup(main_group)
    local group = main_group or vim.api.nvim_create_augroup("CustomAutoCmds", { clear = true })

    vim.api.nvim_create_autocmd("TextYankPost", {
        group = group,
        callback = function()
            vim.highlight.on_yank()
        end,
    })
end

return M
