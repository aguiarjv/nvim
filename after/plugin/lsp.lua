---@diagnostic disable: undefined-global
local lspkind = require("lspkind")
lspkind.init()

local cmp = require("cmp")

cmp.setup({
	mapping = {
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-u>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.abort(),
		["<C-y>"] = cmp.mapping(
			cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
			{ "i", "c" }
		),

		["<C-Space>"] = cmp.mapping({
			i = cmp.mapping.complete(),
			c = function(
				_ --[[fallback]]
			)
				if cmp.visible() then
					if not cmp.confirm({ select = true }) then
						return
					end
				else
					cmp.complete()
				end
			end,
		}),

		-- If you want tab completion :'(
		--  First you have to just promise to read `:help ins-completion`.
		--
		-- ["<Tab>"] = function(fallback)
		--   if cmp.visible() then
		--     cmp.select_next_item()
		--   else
		--     fallback()
		--   end
		-- end,
		-- ["<S-Tab>"] = function(fallback)
		--   if cmp.visible() then
		--     cmp.select_prev_item()
		--   else
		--     fallback()
		--   end
		-- end,
	},
	sources = {
		{ name = "gh_issues" },

		{ name = "nvim_lua" },

		{ name = "nvim_lsp" },
		{ name = "cmp_tabnine" },
		{ name = "path", keyword_length = 3 },
		{ name = "luasnip" },
		{ name = "buffer", keyword_length = 5 },
	},

	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	formatting = {
		format = lspkind.cmp_format({
			with_text = true,
			menu = {
				buffer = "[buf]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[api]",
				path = "[path]",
				luasnip = "[snip]",
				gh_issues = "[issues]",
				cmp_tabnine = "[TabNine]",
			},
		}),
	},
})

-- Cmp Tabnine Plugin
local tabnine = require("cmp_tabnine.config")
tabnine:setup({
	max_lines = 500,
	max_num_results = 20,
	sort = true,
	run_on_every_keystroke = true,
	snippet_placeholder = "..",
})

-- nvim lsp config
local function config(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
		on_attach = function()
			vim.keymap.set("n", "gd", function()
				vim.lsp.buf.definition()
			end)
			vim.keymap.set("n", "gD", function()
				vim.lsp.buf.declaration()
			end)
			vim.keymap.set("n", "gl", function()
				vim.diagnostic.open_float()
			end)
			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover()
			end)
			vim.keymap.set("n", "<leader>vws", function()
				vim.lsp.buf.workspace_symbol()
			end)
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.goto_next()
			end)
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.goto_prev()
			end)
			vim.keymap.set("n", "<leader>vca", function()
				vim.lsp.buf.code_action()
			end)
			vim.keymap.set("n", "<leader>vco", function()
				vim.lsp.buf.code_action({
					filter = function(code_action)
						if not code_action or not code_action.data then
							return false
						end

						local data = code_action.data.id
						return string.sub(data, #data - 1, #data) == ":0"
					end,
					apply = true,
				})
			end)
			vim.keymap.set("n", "<leader>vrr", function()
				vim.lsp.buf.references()
			end)
			vim.keymap.set("n", "<leader>vrn", function()
				vim.lsp.buf.rename()
			end)
			vim.keymap.set("i", "<C-h>", function()
				vim.lsp.buf.signature_help()
			end)
		end,
	}, _config or {})
end

-- language servers setup
--[[ require("lspconfig").pyright.setup(config()) ]]
require("lspconfig").pylsp.setup(config({
	settings = { pylsp = {
		plugins = {
			pycodestyle = {
				maxLineLength = 100,
			},
		},
	} },
}))

require("lspconfig").lua_ls.setup(config())
require("lspconfig").cssls.setup(config())
require("lspconfig").emmet_ls.setup(config())
require("lspconfig").html.setup(config())
require("lspconfig").tsserver.setup(config())
require("lspconfig").gopls.setup(config())
require("lspconfig").tailwindcss.setup(config())

-- Symbols Outline Plugin Config
local opts = {
	-- whether to highlight the currently hovered symbol
	-- disable if your cpu usage is higher than you want it
	-- or you just hate the highlight
	-- default: true
	highlight_hovered_item = true,

	-- whether to show outline guides
	-- default: true
	show_guides = true,
}

require("symbols-outline").setup(opts)

-- Luasnip config using friendly snippets
require("luasnip.loaders.from_vscode").lazy_load()
