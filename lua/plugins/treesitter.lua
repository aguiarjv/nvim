return {
    {
        "nvim-treesitter/nvim-treesitter",
        enabled = true,
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                "java",
                "tsx",
                "typescript",
                "javascript",
                "json",
                "html",
                "css",
                "lua",
                "markdown",
                "markdown_inline",
            })

            -- -- Performance optimizations for large files
            -- opts.highlight = opts.highlight or {}
            -- opts.highlight.enable = true
            -- opts.highlight.disable = function(lang, bufnr)
            --     -- Disable for large files (increased threshold)
            --     local max_filesize = 200 * 1024 -- 200 KB (was 100 KB)
            --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
            --     if ok and stats and stats.size > max_filesize then
            --         return true
            --     end
            --
            --     -- Disable for minified files
            --     local filename = vim.api.nvim_buf_get_name(bufnr)
            --     if filename:match("%.min%.") then
            --         return true
            --     end
            --
            --     -- Performance check: disable if buffer has too many lines
            --     local line_count = vim.api.nvim_buf_line_count(bufnr)
            --     return line_count > 5000
            -- end
            --
            -- -- Additional performance settings
            -- opts.highlight.additional_vim_regex_highlighting = false
            -- opts.highlight.use_languagetree = true
            --
            -- -- Ativar indentação baseada em árvore com performance tweaks
            -- opts.indent = {
            --     enable = true,
            --     -- Disable for problematic languages in large files
            --     disable = function(lang, bufnr)
            --         local line_count = vim.api.nvim_buf_line_count(bufnr)
            --         -- Disable treesitter indent for very large TypeScript files
            --         if (lang == "typescript" or lang == "tsx") and line_count > 2000 then
            --             return true
            --         end
            --         return false
            --     end,
            -- }
            --
            -- -- Ativar autotag para React/HTML com performance considerations
            -- opts.autotag = {
            --     enable = true,
            --     enable_rename = true,
            --     enable_close = true,
            --     enable_close_on_slash = true,
            --     filetypes = {
            --         "html",
            --         "javascript",
            --         "typescript",
            --         "javascriptreact",
            --         "typescriptreact",
            --         "svelte",
            --         "vue",
            --         "tsx",
            --         "jsx",
            --         "rescript",
            --         "xml",
            --         "php",
            --         "markdown",
            --         "astro",
            --         "glimmer",
            --         "handlebars",
            --         "hbs",
            --     },
            -- }
            --
            -- -- Incremental selection optimization
            -- opts.incremental_selection = {
            --     enable = true,
            --     keymaps = {
            --         init_selection = "<C-space>",
            --         node_incremental = "<C-space>",
            --         scope_incremental = false, -- Disable to improve performance
            --         node_decremental = "<bs>",
            --     },
            -- }
            --
            -- -- Text objects with performance considerations
            -- opts.textobjects = {
            --     select = {
            --         enable = true,
            --         lookahead = true, -- Automatically jump forward to textobj
            --         keymaps = {
            --             ["af"] = "@function.outer",
            --             ["if"] = "@function.inner",
            --             ["ac"] = "@class.outer",
            --             ["ic"] = "@class.inner",
            --         },
            --     },
            --     move = {
            --         enable = true,
            --         set_jumps = true, -- whether to set jumps in the jumplist
            --         goto_next_start = {
            --             ["]m"] = "@function.outer",
            --             ["]]"] = "@class.outer",
            --         },
            --         goto_next_end = {
            --             ["]M"] = "@function.outer",
            --             ["]["] = "@class.outer",
            --         },
            --         goto_previous_start = {
            --             ["[m"] = "@function.outer",
            --             ["[["] = "@class.outer",
            --         },
            --         goto_previous_end = {
            --             ["[M"] = "@function.outer",
            --             ["[]"] = "@class.outer",
            --         },
            --     },
            -- }
            --
            -- -- Rainbow parentheses with performance limits
            -- opts.rainbow = {
            --     enable = true,
            --     extended_mode = false, -- Disable for better performance
            --     max_file_lines = 2000, -- Disable for files with more than 2000 lines
            -- }
            --
            -- -- Context showing (shows current function/class context)
            -- opts.context_commentstring = {
            --     enable = true,
            --     enable_autocmd = false, -- Disable autocmd for better performance
            -- }
            --
            -- -- Fold settings for better performance
            -- opts.fold = {
            --     enable = false, -- Disable treesitter folding for performance
            -- }
        end,
    },

    -- Additional treesitter plugins for better React/TS experience
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = "nvim-treesitter/nvim-treesitter",
    },
}
