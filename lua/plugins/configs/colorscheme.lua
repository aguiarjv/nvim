-- Tokyonight
-- return {
--     "folke/tokyonight.nvim",
--     lazy = false,
--     priority = 1000,
--     opts = {
--         style = "moon",
--         transparent = true,
--         styles = {
--             sidebars = "transparent",
--             floats = "transparent",
--         },
--     },
--     config = function(_, opts)
--         require("tokyonight").setup(opts)
--         vim.cmd.colorscheme("tokyonight")
--     end,
-- }

-- Rose Pine
return {
    "rose-pine/neovim",
    lazy = false,
    name = "rose-pine",
    opts = {
        variant = "moon",
        styles = {
            bold = true,
            italic = true,
            transparency = true,
        },
    },
    config = function(_, opts)
        require("rose-pine").setup(opts)
        vim.cmd.colorscheme("rose-pine")
    end,
}
