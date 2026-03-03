-- Changing default cache and data directories
local user = vim.loop.os_get_passwd().username

vim.env.XDG_CACHE_HOME = "/var/tmp/" .. user .. "/xdg-cache"
vim.env.XDG_DATA_HOME = "/var/tmp/" .. user .. "/xdg-data"

vim.fn.mkdir(vim.env.XDG_CACHE_HOME, "p")
vim.fn.mkdir(vim.env.XDG_DATA_HOME, "p")

-- Initialize neovim configs
require("config.lazy")
