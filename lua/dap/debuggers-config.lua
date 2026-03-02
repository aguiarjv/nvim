return {
    dependencies = {
        require("dap.configs.clangd").dependencies,
    },
    setup = function()
        require("dap.configs.clangd").setup()
        require("dap.configs.jdtls").setup()
    end,
}
