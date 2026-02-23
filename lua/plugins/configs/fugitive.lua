return {
    {
        "tpope/vim-fugitive",
        cmd = "Git",
        keys = {
            { "<leader>gg", "<cmd>Git<cr>", desc = "Fugitive" },
            { "gh", "<cmd>diffget //2<cr>", desc = "Vim diffget Left" },
            { "gl", "<cmd>diffget //3<cr>", desc = "Vim diffget Right" },
        },
    },
}
