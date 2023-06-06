require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	sync_install = false,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	context_commentstring = {
		enable = true,
	},
	autopairs = {
		enable = true,
	},
})
