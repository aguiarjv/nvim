return {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    cmd = "ConformInfo",
    keys = {
        {
            "<leader>cF",
            function()
                require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
            end,
            mode = { "n", "x" },
            desc = "Format Injected Langs",
        },
    },
    event = { "BufWritePre" },
    -- This will provide type hinting with LuaLS
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
        -- Define your formatters
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "black" },
            javascript = { "prettierd", "prettier", stop_after_first = true },
            c = { "clang-format" },
            cpp = { "clang-format" },
            java = { "google-java-format" },
        },
        -- Set default options
        default_format_opts = {
            lsp_format = "fallback",
        },
        -- Set up format-on-save
        format_on_save = { timeout_ms = 500 },
        -- Customize formatters
        formatters = {
            shfmt = {
                append_args = { "-i", "2" },
            },
            ["clang-format"] = {
                args = '--style="{BasedOnStyle: llvm, IndentWidth: 4}"',
            },
            ["google-java-format"] = {
                append_args = { "--aosp" }, -- aosp flag uses another style that uses 4 spaces
            },
        },
    },
    init = function()
        -- If you want the formatexpr, here is the place to set it
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
