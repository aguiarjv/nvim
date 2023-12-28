-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	use("sbdchd/neoformat") -- Need to install formatters

	-- nvim tree
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional
		},
	})

	-- indent scope
	use("lukas-reineke/indent-blankline.nvim")

	-- mason portable package manager
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("WhoIsSethDaniel/mason-tool-installer.nvim")

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

	-- Snippets
	use("saadparwaiz1/cmp_luasnip")
	use("L3MON4D3/LuaSnip")

	use("rafamadriz/friendly-snippets")

	use("simrat39/symbols-outline.nvim")

	-- Colorschemes
	use("folke/tokyonight.nvim")
	use("gruvbox-community/gruvbox")
	use({ "rose-pine/neovim", as = "rose-pine" })

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	-- use("norcalli/nvim-colorizer.lua")

	-- Treesitter
	use("nvim-treesitter/nvim-treesitter", {
		run = ":TSUpdate",
	})

	use("nvim-treesitter/playground")
	use("romgrk/nvim-treesitter-context")

	-- Commenting
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("numToStr/Comment.nvim")

	-- Auto pairs
	use("windwp/nvim-autopairs")

	-- Debugging
	use("mfussenegger/nvim-dap")
	use("mfussenegger/nvim-dap-python")
	use("rcarriga/nvim-dap-ui")
	use("theHamsta/nvim-dap-virtual-text")

	-- Git
	use("tpope/vim-fugitive")

	-- Undo tre
	use("mbbill/undotree")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
