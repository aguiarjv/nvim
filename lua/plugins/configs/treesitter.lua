return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
        local TS = require("nvim-treesitter")
        TS.install({
            "c",
            "cpp",
            "java",
            "javascript",
            "python",
            "tsx",
            "typescript",
            "go",
            "rust",
            "lua",
            --
            "bash",
            "json",
            "html",
            "css",
            "diff",
            "jsdoc",
            "luadoc",
            "luap",
            "markdown",
            "markdown_inline",
            "printf",
            "query",
            "regex",
            "toml",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
        })

        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local filetype = vim.bo[args.buf].filetype
                local disable_folds = {
                    javascript = true,
                    javascriptreact = true,
                    typescript = true,
                    typescriptreact = true,
                }

                if disable_folds[filetype] then
                    vim.opt_local.foldmethod = "manual"
                else
                    vim.opt_local.foldmethod = "expr"
                    vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                end

                pcall(vim.treesitter.start, args.buf)
            end,
        })
    end,
}
