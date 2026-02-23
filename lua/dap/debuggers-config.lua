return {
    dependencies = {
        require("dap.configs.clangd").dependencies,
    },
    setup = function()
        require("dap.configs.clangd").setup()
    end,
}
