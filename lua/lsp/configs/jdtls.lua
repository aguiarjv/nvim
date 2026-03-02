local M = {}

---@return table|nil
function M.get_config()
    local fname = vim.api.nvim_buf_get_name(0)

    local root_dir = vim.fs.root(fname, vim.lsp.config.jdtls.root_markers)
    if not root_dir then
        return nil
    end

    local project_name = vim.fs.basename(root_dir)

    local cmd = { vim.fn.exepath("jdtls") }

    -- Lombok Mason
    local ok, registry = pcall(require, "mason-registry")
    if ok and registry.is_installed("jdtls") then
        local lombok = vim.fn.expand("$MASON/share/jdtls/lombok.jar")
        if vim.fn.filereadable(lombok) == 1 then
            table.insert(cmd, "--jvm-arg=-javaagent:" .. lombok)
        end
    end

    vim.list_extend(cmd, {
        "-configuration",
        vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config",
        "-data",
        vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace",
    })

    local bundles = {}

    -- Java debug + test
    if ok then
        if registry.is_installed("java-debug-adapter") then
            vim.list_extend(
                bundles,
                vim.fn.glob("$MASON/share/java-debug-adapter/com.microsoft.java.debug.plugin-*.jar", false, true)
            )
        end

        if registry.is_installed("java-test") then
            vim.list_extend(bundles, vim.fn.glob("$MASON/share/java-test/*.jar", false, true))
        end
    end

    local capabilities = require("lsp.capabilities").get and require("lsp.capabilities").get() or nil

    local runtimes = require("lsp.helpers.java-runtimes").find()

    return {
        cmd = cmd,
        root_dir = root_dir,
        capabilities = capabilities,

        init_options = {
            bundles = bundles,
        },

        settings = {
            java = {
                configuration = {
                    runtimes = runtimes,
                },
                inlayHints = {
                    parameterNames = {
                        enabled = "all",
                    },
                },
                eclipse = { downloadSources = true },
                maven = { downloadSources = true },
                references = { includeDecompiledSources = true },
                format = { enabled = false },
            },
        },
    }
end

function M.setup()
    local config = M.get_config()
    if not config then
        return
    end

    require("jdtls").start_or_attach(config)
end

return M
