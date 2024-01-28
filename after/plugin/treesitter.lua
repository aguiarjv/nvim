require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "vim", "vimdoc", "javascript", "json", "python", "tsx", "query" },
	sync_install = false,
	auto_install = true,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	autopairs = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
})

require("ts_context_commentstring").setup({
	enable_autocmd = false,
})
