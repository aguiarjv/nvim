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

        -- Autoformatting
        "stevearc/conform.nvim",

        -- Schema information
        "b0o/SchemaStore.nvim",
    },
    config = function()
        local servers = require("lsp.servers-config")
        local capabilities = require("lsp.capabilities").get()
        local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
        local servers_to_enable = {}
        local deferred_servers = {}

        local current_path = vim.env.PATH or ""
        if not current_path:find(mason_bin, 1, true) then
            vim.env.PATH = current_path == "" and mason_bin or mason_bin .. ":" .. current_path
        end

        local function start_config(bufnr, name)
            if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].buftype ~= "" then
                return
            end

            if vim.lsp.get_clients({ bufnr = bufnr, name = name })[1] then
                return
            end

            local config = vim.deepcopy(vim.lsp.config[name])
            if not config then
                return
            end

            if config.filetypes and not vim.tbl_contains(config.filetypes, vim.bo[bufnr].filetype) then
                return
            end

            local opts = {
                bufnr = bufnr,
                reuse_client = config.reuse_client,
                _root_markers = config.root_markers,
                silent = true,
            }

            if type(config.root_dir) == "function" then
                config.root_dir(bufnr, function(root_dir)
                    config.root_dir = root_dir
                    vim.schedule(function()
                        if vim.api.nvim_buf_is_valid(bufnr) then
                            vim.lsp.start(config, opts)
                        end
                    end)
                end)
            else
                vim.lsp.start(config, opts)
            end
        end

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
            local defer_start = lsp_config.defer_start

            -- Remove local-only flags as they are not LSP config fields
            lsp_config.manual_install = nil
            lsp_config.defer_start = nil

            vim.lsp.config(name, lsp_config)

            if defer_start then
                local resolved_config = vim.lsp.config[name]
                deferred_servers[name] = {
                    delay = defer_start,
                    filetypes = resolved_config and resolved_config.filetypes or {},
                }
            else
                table.insert(servers_to_enable, name)
            end

            ::continue::
        end

        if #servers_to_enable > 0 then
            vim.lsp.enable(servers_to_enable)
        end

        local deferred_filetypes = {}
        for _, server in pairs(deferred_servers) do
            for _, filetype in ipairs(server.filetypes) do
                deferred_filetypes[filetype] = true
            end
        end

        if next(deferred_filetypes) then
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("UserDeferredLspStart", { clear = true }),
                pattern = vim.tbl_keys(deferred_filetypes),
                callback = function(args)
                    local filetype = vim.bo[args.buf].filetype

                    for name, server in pairs(deferred_servers) do
                        if vim.tbl_contains(server.filetypes, filetype) then
                            vim.defer_fn(function()
                                start_config(args.buf, name)
                            end, server.delay)
                        end
                    end
                end,
            })
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
