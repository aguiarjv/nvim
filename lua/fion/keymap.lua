vim.keymap.set("i", "<C-c>", "<esc>")

-- Moving visual selection up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "Y", "yg$")

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

-- Move between split windows
vim.keymap.set("n", "<leader>h", ":wincmd h<CR>")
vim.keymap.set("n", "<leader>j", ":wincmd j<CR>")
vim.keymap.set("n", "<leader>k", ":wincmd k<CR>")
vim.keymap.set("n", "<leader>l", ":wincmd l<CR>")

-- Telescope
vim.keymap.set("n", "<C-p>", function()
	require("telescope.builtin").git_files()
end)

vim.keymap.set("n", "<leader>ft", function()
	require("telescope-tabs").list_tabs()
end)

vim.keymap.set("n", "<leader>ff", function()
	require("telescope.builtin").find_files()
end)
vim.keymap.set("n", "<leader>fg", function()
	require("telescope.builtin").live_grep()
end)
vim.keymap.set("n", "<leader>fb", function()
	require("telescope.builtin").buffers()
end)

vim.keymap.set("n", "<leader>fh", function()
	require("telescope.builtin").help_tags()
end)

vim.keymap.set("n", "<leader>fs", function()
	require("telescope.builtin").grep_string({ search = vim.fn.input("Grep for > ") })
end)
vim.keymap.set("n", "<leader>fw", function()
	require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })
end)

-- Git
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

vim.keymap.set("n", "<leader>ga", "<cmd>!git fetch --all<CR>")
