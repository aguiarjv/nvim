local Remap = require("fion.remap")

local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

inoremap("<C-c>", "<esc>")

vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

nnoremap("Y", "yg$")
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
nnoremap("J", "mzJ`z")
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")

-- Replaces currently selected text with default register without yanking it
xnoremap("<leader>p", "\"_dP")

nnoremap("<leader>y", "\"+y")
vnoremap("<leader>y", "\"+y")
nmap("<leader>Y", "\"+Y")

nnoremap("x", "\"_x")

-- Deletes without saving to register
nnoremap("<leader>d", "\"_d")
vnoremap("<leader>d", "\"_d")

vnoremap("<leader>d", "\"_d")

-- Open file tree as split and resizes it
nnoremap("<leader>pv", ":tabnew v<bar> :Ex <bar> :vertical resize 30<CR>")

-- Move between split windows
nnoremap("<leader>h", ":wincmd h<CR>")
nnoremap("<leader>j", ":wincmd j<CR>")
nnoremap("<leader>k", ":wincmd k<CR>")
nnoremap("<leader>l", ":wincmd l<CR>")

-- Telescope
nnoremap("<C-p>", function() require('telescope.builtin').git_files() end)

nnoremap("<leader>ft", function() require('telescope-tabs').list_tabs() end)

nnoremap("<leader>ff", function() require('telescope.builtin').find_files() end)
nnoremap("<leader>fg", function() require('telescope.builtin').live_grep() end)
nnoremap("<leader>fb", function() require('telescope.builtin').buffers() end)

nnoremap("<leader>fh", function() require('telescope.builtin').help_tags() end)

nnoremap("<leader>fs", function() require('telescope.builtin').grep_string({ search = vim.fn.input("Grep for > ")}) end)
nnoremap("<leader>fw", function() require('telescope.builtin').grep_string({ search = vim.fn.expand("<cword>")}) end)


