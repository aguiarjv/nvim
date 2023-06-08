vim.g.tokyonight_transparent_sidebar = true
vim.g.tokyonight_transparent = true

vim.g.gruvbox_contrast_dark = "hard"
vim.g.gruvbox_invert_selection = "0"
vim.g.gruvbox_sign_column = "none"

vim.opt.background = "dark"

require("rose-pine").setup({ disable_italics = true })
vim.cmd.colorscheme("rose-pine")

-- vim.cmd.colorscheme("tokyonight-moon")
-- vim.cmd.colorscheme("gruvbox")

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
--[[ vim.api.nvim_set_hl(0, "CursorLineNR", { bg = "none" }) ]]

-- vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NvimTreeNormalFloat", { bg = "none" })

-- Changing the EndOfBuffer character from "~" to " "
vim.opt.fillchars:append("eob: ")

-- Status line config
require("lualine").setup({
	options = { theme = "iceberg_dark" },
})

-- iceberg_dark, gruvbox-material, dracula
