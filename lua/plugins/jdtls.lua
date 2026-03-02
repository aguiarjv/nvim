return {
    "mfussenegger/nvim-jdtls",
    opts = {
        jdtls = function(opts)
            -- Setting java executable path
            local home = "/usr/lib/jvm"
            local java_home = home .. "/java-21-openjdk-amd64"
            local java_executable = java_home .. "/bin/java"

            -- The opts.cmd list will be passed as arguments to a jdtls.py script inside the mason/packages/jdtls/bin directory
            table.insert(opts.cmd, "--java-executable=" .. java_executable)

            -- Adding runtimes
            if not opts.settings then
                opts.settings = {}
            end
            if not opts.settings.java then
                opts.settings.java = {}
            end
            opts.settings.java.configuration = {
                runtimes = {
                    {
                        name = "JavaSE-21",
                        path = java_home,
                        default = true,
                    },
                    {
                        name = "JavaSE-11",
                        path = "/usr/lib/jvm/java-11-openjdk-amd64",
                    },
                },
            }
            return opts
        end,
    },
}
