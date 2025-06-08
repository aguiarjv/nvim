return {
    "neovim/nvim-lspconfig",
    opts = {
        format = { timeout_ms = 30000 },
        default_format_opts = { timeout_ms = 30000 },
        servers = {
            eslint = {
                enabled = true,
            },
            vtsls = {
                enabled = false,
            },
            ts_ls = {
                enabled = false,
            },
            tsserver = {
                enabled = false,
                init_options = {
                    preferences = {
                        disableSuggestions = false,
                    },
                },
                settings = {
                    typescript = {
                        inlayHints = {
                            includeInlayEnumMemberValueHints = false,
                            includeInlayFunctionParameterTypeHints = false,
                            includeInlayFunctionLikeReturnTypeHints = false,
                            includeInlayParameterNameHints = "none",
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayPropertyDeclarationTypeHints = false,
                            includeInlayVariableTypeHints = false,
                            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                        },
                    },
                    completions = {
                        completeFunctionCalls = true,
                    },
                },
                flags = {
                    debounce_text_changes = 300,
                },
                keys = {
                    {
                        "<leader>co",
                        function()
                            vim.lsp.buf.code_action({
                                apply = true,
                                context = {
                                    only = { "source.organizeImports.ts" },
                                    diagnostics = {},
                                },
                            })
                        end,
                        desc = "Organize Imports",
                    },
                    {
                        "<leader>cR",
                        function()
                            vim.lsp.buf.code_action({
                                apply = true,
                                context = {
                                    only = { "source.removeUnused.ts" },
                                    diagnostics = {},
                                },
                            })
                        end,
                        desc = "Remove Unused Imports",
                    },
                },
            },
        },
        setup = {
            tsserver = function()
                return true
            end,
            vtsls = function()
                return true
            end,
        },
    },
}
