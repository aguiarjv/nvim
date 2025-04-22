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
                json = { "prettierd" },
                tsx = { "prettierd" },
                jsx = { "prettierd" },
                javascript = { "prettierd" },
                typescript = { "prettierd" },
                markdown = { "prettierd" },
            },
        },
    },
}
