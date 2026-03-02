return {
    dependencies = {
        {
            "mason-org/mason.nvim",
            optional = true,
            opts = { ensure_installed = { "java-debug-adapter", "java-test" } },
        },
    },
    setup = function()
        local dap = require("dap")
        dap.configurations["java"] = {
            {
                type = "java",
                request = "attach",
                name = "Debug Remote (Attach) 5005",
                hostName = "127.0.0.1",
                port = 5005,
            },
            {
                type = "java",
                request = "attach",
                name = "Debug Remote (Attach) 5006",
                hostName = "127.0.0.1",
                port = 5006,
            },
        }
    end,
}
