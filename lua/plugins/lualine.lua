return {
    {
        "nvim-lualine/lualine.nvim",
        enabled = false,
        opts = {
            refresh = {
                statusline = 1500,
                tabline = 1500,
                winbar = 1500,
            },
            sections = {
                lualine_a = { "branch" },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {
                    { "progress", separator = " ", padding = { left = 1, right = 0 } },
                    { "location", padding = { left = 0, right = 1 } },
                },
                lualine_z = {},
            },
            extensions = {},
        },
    },
}
