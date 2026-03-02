return {
    "neovim/nvim-lspconfig",
    opts = {
        format = { timeout_ms = 30000 },
        default_format_opts = { timeout_ms = 30000 },
        servers = {
            eslint = {
                enabled = true,
                settings = {
                    format = false,
                    workingDirectories = {
                        "live-plugins",
                        "liverig",
                        "live",
                        "webapp",
                    },
                },
            },
        },
    },
}
