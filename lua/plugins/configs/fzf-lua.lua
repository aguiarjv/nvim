return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "nvim-mini/mini.icons" },
    opts = {},
    config = function()
        require("fzf-lua").register_ui_select()
    end,
    keys = {
        { "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
        { "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },
        {
            "<leader>,",
            "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
            desc = "Switch Buffer",
        },
        { "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
        {
            "<leader>/",
            function()
                require("fzf-lua").live_grep()
            end,
            desc = "Grep",
        },
        -- find
        {
            "<leader>ff",
            function()
                require("fzf-lua").files()
            end,
            desc = "Find Files",
        },
        { "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
        { "<leader>fB", "<cmd>FzfLua buffers<cr>", desc = "Buffers (all)" },
        { "<leader>fg", "<cmd>FzfLua git_files<cr>", desc = "Find Files (git-files)" },
        { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
        -- git
        { "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "Commits (Project)" },
        { "<leader>gC", "<cmd>FzfLua git_bcommits<CR>", desc = "Commits (Buffer)" },
        { "<leader>gb", "<cmd>FzfLua git_blame<CR>", desc = "Blame" },
        { "<leader>gB", "<cmd>FzfLua git_branches<CR>", desc = "Branches" },
        { "<leader>gw", "<cmd>FzfLua git_worktrees<CR>", desc = "Worktrees" },
        { "<leader>gd", "<cmd>FzfLua git_diff<cr>", desc = "Git Diff (hunks)" },
        { "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Status" },
        { "<leader>gS", "<cmd>FzfLua git_stash<cr>", desc = "Git Stash" },
        -- search
        { '<leader>s"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
        { "<leader>s/", "<cmd>FzfLua search_history<cr>", desc = "Search History" },
        { "<leader>sa", "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
        { "<leader>sb", "<cmd>FzfLua lines<cr>", desc = "Buffer Lines" },
        { "<leader>sc", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
        { "<leader>sC", "<cmd>FzfLua commands<cr>", desc = "Commands" },
        { "<leader>sd", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Diagnostics" },
        { "<leader>sD", "<cmd>FzfLua diagnostics_document<cr>", desc = "Buffer Diagnostics" },
        { "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
        { "<leader>sH", "<cmd>FzfLua highlights<cr>", desc = "Search Highlight Groups" },
        { "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
        { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
        { "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "Location List" },
        { "<leader>sM", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
        { "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
        { "<leader>sR", "<cmd>FzfLua resume<cr>", desc = "Resume" },
        { "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
        {
            "<leader>sw",
            function()
                require("fzf-lua").grep_cword()
            end,
            desc = "Word",
        },
        {
            "<leader>sw",
            function()
                require("fzf-lua").grep_visual()
            end,
            desc = "Selection",
            mode = "x",
        },
        {
            "<leader>ss",
            function()
                require("fzf-lua").lsp_document_symbols({
                    regex_filter = symbols_filter,
                })
            end,
            desc = "Goto Symbol",
        },
        {
            "<leader>sS",
            function()
                require("fzf-lua").lsp_live_workspace_symbols({
                    regex_filter = symbols_filter,
                })
            end,
            desc = "Goto Symbol (Workspace)",
        },
    },
}
