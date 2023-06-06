# Keymaps

These are the current mappings I'm using on my nvim workflow. <br />
My leader-key for nvim is: **space**

---

## Table of Contents

- [Nvim-Tree](#nvim-tree)
- [Telescope](#telescope)
- [LSP](#lsp)
- [Commenting](#commenting)
- [Debugging](#debugging)
- [Git](#git)

---

## Nvim-Tree
Reference: [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)
To see the full mappings list check the [nvim-tree-on-attach.lua](./lua/fion/nvim-tree/nvim-tree-on-attach.lua)

- **\<leader\>pe**: Toggles nvim-tree
- **(on nvim-tree) v**: opens file in split
- **(on nvim-tree) l**: opens/closes nodes and opens files
- **(on nvim-tree) h**: closes nodes
- **(on nvim-tree) CTRL + t**: opens file on new tab
- **(on nvim-tree) a**: creates new file
- **(on nvim-tree) d**: deletes a file
- **(on nvim-tree) r**: renames a file

## Telescope
Reference: [Telescope](https://github.com/nvim-telescope/telescope.nvim)

- **CTRL + p**: git files
- **\<leader\>ft**: list tabs
- **\<leader\>ff**: find files
- **\<leader\>fg**: live grep
- **\<leader\>fb**: list buffers
- **\<leader\>fh**: help tags
- **\<leader\>fs**: grep string
- **\<leader\>fw**: grep word on cursor

## LSP
References: [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) and [nvim-lsp](https://github.com/neovim/nvim-lspconfig)

-(cmp) **CTRL + n**: select next item
-(cmp) **CTRL + p**: select previous item
-(cmp) **CTRL + d**: scroll docs (-4)
-(cmp) **CTRL + u**: scroll docs (+4)
-(cmp) **CTRL + e**: abort
-(cmp) **CTRL + y**: confirm
-(cmp) **CTRL + space**: cmp.mapping.complete() (check reference)
<br />

- **gd**: go to definition
- **gD**: go to declaration
- **gl**: diagnostics open float
- **K**: displays hover information abou the symbol under the cursor
- **[d**: move to the previous diagnostic in the current buffer
- **]d**: move to the next diagnostic in the current buffer
- **CTRL + hd**: displays signature information about the symbol under the cursor
- **\<leader\>vws**: lists all synmbols in the current workspace in the quickfix window
- **\<leader\>vca**: selects a code action available at the current cursor position
- **\<leader\>vco**: code action
- **\<leader\>vrr**: lists all the references to the symbol under the curosr in the quickfix window
- **\<leader\>vrn**: renames all references to the symbol under the cursor

## Commenting
Reference: [Comment.nvim](https://github.com/numToStr/Comment.nvim)

- **gcc**: toggle comment on the line under the cursor
- (visual mode)**gc**: toggle comment on selected lines

## Debugging
Reference: [nvim-dap](https://github.com/mfussenegger/nvim-dap)

- **Home**: dapui toggle (1)
- **End**: dapui toggle (2)
- **Up**: dap continue
- **Down**: dap step over
- **Right**: dap step into
- **Left**: dap step out
- **\<leader\>\<leader\>**: dap close
- **\<leader\>db**: toggle breakpoint
- **\<leader\>dB**: set breakpoint with breakpoint condition
- **\<leader\>dpr**: dap-python.test_method()
- **\<leader\>rc**: dap.run_to_cursor()

## Git
Reference: [vim-fugitive](https://github.com/tpope/vim-fugitive)

- **\<leader\>gs**: opens fugitive
