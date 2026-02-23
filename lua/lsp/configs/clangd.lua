return {
    cmd = {
        "clangd",
        "--fallback-style=webkit",
    },
    init_options = { clangdFileStatus = true },

    filetypes = { "c", "cpp" },
}
