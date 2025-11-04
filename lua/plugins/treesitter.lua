return {
    {
        "nvim-treesitter/nvim-treesitter",
        enabled = true,
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                "java",
                "tsx",
                "typescript",
                "javascript",
                "json",
                "html",
                "css",
                "lua",
                "markdown",
                "markdown_inline",
            })
        end,
    },

    -- Additional treesitter plugins for better React/TS experience
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = "nvim-treesitter/nvim-treesitter",
    },
}
