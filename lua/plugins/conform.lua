return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                fish = { "fish_indent" },
                sh = { "shfmt" },
                html = { "prettierd" },
                css = { "prettierd" },
                scss = { "prettierd" },
                less = { "prettierd" },
                vue = { "prettierd" },
                json = { "prettierd" },
                jsonc = { "prettierd" },
                tsx = { "prettierd" },
                jsx = { "prettierd" },
                javascript = { "prettierd" },
                javascriptreact = { "prettierd" },
                typescript = { "prettierd" },
                typescriptreact = { "prettierd" },
                markdown = { "prettierd" },
                yml = { "prettierd" },
            },
        },
    },
}
