return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "mason.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    { "mason-org/mason-lspconfig.nvim", config = function() end },

    -- Autoformatting
    "stevearc/conform.nvim",

    -- Schema information
    "b0o/SchemaStore.nvim",
  },
  config = function()
    local servers = {
      bashls = true,
      lua_ls = {
        cmd = { "lua-language-server" },
        -- server_capabilities = {
        --   semanticTokensProvider = vim.NIL,
        -- },
      },
      jsonls = {
        server_capabilities = {
          documentFormattingProvider = false,
        },
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      },
      clangd = {
        -- cmd = { "clangd", unpack(require("custom.clangd").flags) },
        -- TODO: Could include cmd, but not sure those were all relevant flags.
        --    looks like something i would have added while i was floundering
        init_options = { clangdFileStatus = true },

        filetypes = { "c" },
      },
      pyright = true,
      ruff = { manual_install = true },
      vtsls = {
        server_capabilities = {
          documentFormattingProvider = false,
        },
      },
      tailwindcss = {
        init_options = {
          userLanguages = {
            elixir = "phoenix-heex",
            eruby = "erb",
            heex = "phoenix-heex",
          },
        },
        filetypes = {
          "html",
          "css",
          "scss",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
          "svelte",
          "ocaml.mlx",
        },
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                [[class: "([^"]*)]],
                [[className="([^"]*)]],
              },
            },
            includeLanguages = {
              ["ocaml.mlx"] = "html",
            },
          },
        },
      },
    }

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
      "delve",
      -- "tailwind-language-server",
    }

    vim.list_extend(ensure_installed, servers_to_install)
    require("mason-tool-installer").setup { ensure_installed = ensure_installed }
    -- Configure and enable each LSP server
    for name, config in pairs(servers) do
      if config == true then
        config = {}
      end

      -- Only call vim.lsp.config if there are server-specific settings
      if next(config) ~= nil then
        -- Remove manual_install flag as it's not an LSP config field
        local lsp_config = vim.tbl_deep_extend("force", {}, config)
        lsp_config.manual_install = nil
        vim.lsp.config(name, lsp_config)
      end

      vim.lsp.enable(name)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

        local settings = servers[client.name]
        if type(settings) ~= "table" then
          settings = {}
        end

        local fzf_lua = require "fzf-lua"
        vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
        vim.keymap.set("n", "gd", fzf_lua.lsp_definitions, { buffer = 0 })
        vim.keymap.set("n", "gr", fzf_lua.lsp_references, { buffer = 0 })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
        vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })

        vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
        vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = 0 })
        vim.keymap.set("n", "<space>wd", fzf_lua.lsp_document_symbols, { buffer = 0 })
        vim.keymap.set("n", "<space>ww", function()
          fzf_lua.diagnostics_document { root_dir = true }
        end, { buffer = 0 })

        -- Override server capabilities
        if settings.server_capabilities then
          for k, v in pairs(settings.server_capabilities) do
            if v == vim.NIL then
              ---@diagnostic disable-next-line: cast-local-type
              v = nil
            end

            client.server_capabilities[k] = v
          end
        end
      end,
    })
  end,
}
