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
                vim.opt.foldmethod = "expr"
                vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                pcall(vim.treesitter.start, args.buf)
            end,
        })
    end,
}
