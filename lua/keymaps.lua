vim.keymap.set("i", "<C-c>", "<esc>")

vim.keymap.set("n", "Y", "yg$")

-- Moving visual selection up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keeps the cursor in the middle while moving
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Replaces currently selected text with default register without yanking it
vim.keymap.set("x", "<leader>p", '"_dP')

-- Yanks to your clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y', { noremap = false })

vim.keymap.set("n", "x", '"_x')

-- Deletes without saving to register
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

vim.keymap.set("v", "<leader>d", '"_d')

-- Open file tree as split and resizes it
-- vim.keymap.set("n", "<leader>pv", ":tabnew v<bar> :Ex <bar> :vertical resize 30<CR>")
vim.keymap.set("n", "<leader>pe", ":NvimTreeToggle<cr>")

-- Create New Tab
vim.keymap.set("n", "<leader>st", ":tabnew<CR>")

-- Split Windows
vim.keymap.set("n", "<leader>sb", ":split<CR> <BAR> :wincmd j<CR>")
vim.keymap.set("n", "<leader>sv", ":vsplit <CR> <BAR> :wincmd l<CR>")

-- Move between split windows
vim.keymap.set("n", "<leader>h", ":wincmd h<CR>")
vim.keymap.set("n", "<leader>j", ":wincmd j<CR>")
vim.keymap.set("n", "<leader>k", ":wincmd k<CR>")
vim.keymap.set("n", "<leader>l", ":wincmd l<CR>")
