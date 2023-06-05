vim.g.tokyonight_transparent_sidebar = true
vim.g.tokyonight_transparent = true

vim.g.gruvbox_contrast_dark = 'hard'
vim.g.gruvbox_invert_selection = '0'
vim.g.gruvbox_sign_column = 'none'

vim.opt.background = "dark"

vim.cmd("colorscheme tokyonight-moon")
-- vim.cmd("colorscheme gruvbox")

vim.cmd(":hi normal guibg=000000") -- Transparent background
vim.cmd(":highlight SignColumn guibg=NONE") -- Transparent SignColumn
vim.cmd(":highlight CursorLineNR guibg=NONE") -- Transparent Number Column


-- Status line config
require('lualine').setup {
    options = { theme = 'iceberg_dark' }
}

-- iceberg_dark, gruvbox-material, dracula

