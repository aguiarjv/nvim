return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            indent = {
                enabed = true,

                animate = {
                    enabled = false,
                },
            },
            scope = { enabled = true },
            explorer = {},
            picker = {
                sources = {
                    explorer = {},
                },
            },
        },
        keys = {
            {
                "<leader>e",
                function()
                    require("snacks").explorer()
                end,
                desc = "File tree",
            },
        },
    },
}
