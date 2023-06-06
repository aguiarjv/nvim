## nvim configs
### Prerequisites:
- [neovim](https://github.com/neovim/neovim)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [packer](https://github.com/wbthomason/packer.nvim)

### Keymaps
My mappings can be found in this repo.

### Some issues

[mason](https://github.com/williamboman/mason.nvim) may have a few problems installing some packages.
The problem I had while installing packages for python was solved by installing python3-ven. <br />

[cmp_tabnine](https://github.com/tzachar/cmp-tabnine) some times is not installed properly. You have to execute the install.sh file.
It has to be executed in the folder that packer.nvim installed cmp_tabnine. To find it you can run the following command from your home folder:

```
$ find . -name cmp_tabnine
```
