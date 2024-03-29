---@diagnostic disable: undefined-global
vim.opt.guicursor = ""

vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

vim.opt.signcolumn = "yes"

vim.opt.showmatch = false

vim.opt.errorbells = false

vim.opt.hidden = true

vim.opt.showcmd = true
vim.opt.ruler = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.wrap = false

vim.opt.expandtab = true
vim.opt.textwidth = 200
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.termguicolors = true

vim.opt.re = 0

-- More space for displaying messages
vim.opt.cmdheight = 1

vim.opt.updatetime = 50

vim.g.mapleader = " "

-- Undo tree plugin
-- You have to create the $HOME/.vim/undodir directory
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
