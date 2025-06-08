-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.guicursor = ""

vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

vim.opt.signcolumn = "yes"

vim.opt.showmatch = false

vim.opt.hidden = true

vim.opt.showcmd = true
vim.opt.ruler = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.wrap = false

vim.opt.textwidth = 200
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.termguicolors = true

vim.opt.re = 0

vim.opt.cmdheight = 0

vim.g.matchparen_timeout = 2
vim.g.matchparen_insert_timeout = 2

vim.opt.syntax = "off"
vim.o.foldenable = false

vim.o.spell = false

vim.g.snacks_animate = false

vim.opt.foldmethod = "manual" -- Use manual folding instead of treesitter
vim.opt.foldlevel = 99
vim.opt.conceallevel = 0 -- Disable concealing which can slow things down
vim.opt.synmaxcol = 300 -- Limit syntax highlighting to first 300 columns

vim.lsp.set_log_level("off")
