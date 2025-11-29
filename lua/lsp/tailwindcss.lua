return {
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
}
