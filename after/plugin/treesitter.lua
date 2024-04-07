require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"bash",
		"c",
		"diff",
		"html",
		"javascript",
		"jsdoc",
		"json",
		"jsonc",
		"lua",
		"luadoc",
		"luap",
		"markdown",
		"markdown_inline",
		"python",
		"query",
		"regex",
		"toml",
		"tsx",
		"typescript",
		"vim",
		"vimdoc",
		"xml",
		"yaml",
		"help",
		"cmake",
	},
	sync_install = false,
	auto_install = true,

	indent = { enable = true },

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
		disable = { "lua" },
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
