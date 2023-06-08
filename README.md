## nvim configs
### Prerequisites:
- [neovim](https://github.com/neovim/neovim)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [packer](https://github.com/wbthomason/packer.nvim)
- Create the following directory ([undotree](https://github.com/mbbill/undotree)) <code>$HOME/.vim/undodir/</code>

### Keymaps
For reference my mappings can be found in the [nvim-keymaps.md](./nvim-keymaps.md)

### Some issues

To add new language servers they must be first installed (mason can be used) and then the [lsp config file](./after/plugin/lsp.lua)
should be properly configured.<br />

[mason](https://github.com/williamboman/mason.nvim) may have a few problems installing some packages.
The problem I had while installing packages for python was solved by installing python3-ven. <br />

[cmp_tabnine](https://github.com/tzachar/cmp-tabnine) some times is not installed properly. You have to execute the install.sh file.
It has to be executed in the folder that packer.nvim installed cmp_tabnine. To find it you can run the following command from your home folder:

```
$ find . -name cmp_tabnine
```
