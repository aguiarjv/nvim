-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use("sbdchd/neoformat") -- Need to install formatters

  use("TimUntersberger/neogit")

  -- Telescope
  use("nvim-lua/plenary.nvim")
  use("nvim-lua/popup.nvim")
  use("nvim-telescope/telescope.nvim")

  use("LukasPietzschmann/telescope-tabs")

  -- LSP and Auto Completion
  use("neovim/nvim-lspconfig")

  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-nvim-lua")

  use("tzachar/cmp-tabnine", { run = "./install.sh" })

  use("onsails/lspkind.nvim")

  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")

  use("rafamadriz/friendly-snippets")

  use("simrat39/symbols-outline.nvim")

  use ("lukas-reineke/indent-blankline.nvim")

  -- Colorschemes
  use 'folke/tokyonight.nvim'
  use 'gruvbox-community/gruvbox'

  use {
  'nvim-lualine/lualine.nvim',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- use("norcalli/nvim-colorizer.lua")

  -- Treesitter
  use("nvim-treesitter/nvim-treesitter", {
      run = ":TSUpdate"
  })

  use("nvim-treesitter/playground")
  use("romgrk/nvim-treesitter-context")

  -- Debugging
  use("mfussenegger/nvim-dap")
  use("rcarriga/nvim-dap-ui")
  use("theHamsta/nvim-dap-virtual-text")

  -- Git
  -- use("dinhhuy258/git.nvim")
  -- use("lewis6991/gitsigns.nvim")

end)
