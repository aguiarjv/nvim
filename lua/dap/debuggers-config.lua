return {
    dependencies = {
        require("dap.clangd").dependencies,
    },
    setup = function()
        require("dap.clangd").setup()
    end,
}
