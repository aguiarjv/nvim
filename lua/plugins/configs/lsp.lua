return {
    "neovim/nvim-lspconfig",
    dependencies = {
        {
            -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
            -- used for completion, annotations and signatures of Neovim apis
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
                library = {
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "luvit-meta/library", words = { "vim%.uv" } },
                    { path = "/usr/share/awesome/lib/", words = { "awesome" } },
                },
            },
        },
        { "Bilal2453/luvit-meta", lazy = true },
        "mason.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        { "mason-org/mason-lspconfig.nvim", config = function() end },

        -- Autoformatting
        "stevearc/conform.nvim",

        -- Schema information
        "b0o/SchemaStore.nvim",
    },
    config = function()
        local servers = require("lsp.servers-config")

        local servers_to_install = vim.tbl_filter(function(key)
            local t = servers[key]
            if type(t) == "table" then
                return not t.manual_install
            else
                return t
            end
        end, vim.tbl_keys(servers))

        require("mason").setup()
        local ensure_installed = {
            "stylua",
            "lua_ls",
        }

        vim.list_extend(ensure_installed, servers_to_install)
        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

        local capabilities = require("lsp.capabilities").get()

        -- Configure and enable each LSP server
        for name, config in pairs(servers) do
            if name == "jdtls" then -- not configuring jdtls using vim.lsp
                goto continue
            end

            if config == true then
                config = {}
            end

            -- Always using capabilities
            local base_config = {
                capabilities = capabilities,
            }

            -- Extendind existing config
            local lsp_config = vim.tbl_deep_extend("force", base_config, config or {})

            -- Remove manual_install flag as it's not an LSP config field
            lsp_config.manual_install = nil

            vim.lsp.config(name, lsp_config)

            if not vim.lsp.get_clients({ name = name })[1] then
                vim.lsp.enable(name)
            end

            ::continue::
        end

        -- On attach
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
            callback = function(args)
                local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

                local settings = servers[client.name]
                if type(settings) ~= "table" then
                    settings = {}
                end

                -- Set keymaps
                require("lsp.keymaps").on_attach(client, args.buf)

                -- Override server capabilities
                -- if settings.server_capabilities then
                --     for k, v in pairs(settings.server_capabilities) do
                --         if v == vim.NIL then
                --             ---@diagnostic disable-next-line: cast-local-type
                --             v = nil
                --         end
                --
                --         client.server_capabilities[k] = v
                --     end
                -- end
            end,
        })

        -- Diagnostics config
        local diagnostics_icons = require("config.icons").diagnostics
        vim.diagnostic.config({
            virtual_lines = {
                current_line = true,
            },
            -- severity_sort = true,
            -- float = {
            --     border = "rounded",
            --     source = true,
            -- },
            underline = true,
            update_in_insert = false,
            virtual_text = false,
            -- virtual_text = {
            --     spacing = 4,
            --     source = "if_many",
            --     prefix = "●",
            --     -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
            --     -- prefix = "icons",
            -- },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = diagnostics_icons.Error,
                    [vim.diagnostic.severity.WARN] = diagnostics_icons.Warn,
                    [vim.diagnostic.severity.INFO] = diagnostics_icons.Info,
                    [vim.diagnostic.severity.HINT] = diagnostics_icons.Hint,
                },
                numhl = {
                    [vim.diagnostic.severity.ERROR] = "ErrorMsg",
                    [vim.diagnostic.severity.WARN] = "WarningMsg",
                },
            },
        })
    end,
}
