local M = {}

local uv = vim.uv or vim.loop

local function is_dir(path)
    local stat = uv.fs_stat(path)
    return stat and stat.type == "directory"
end

local function scandir(dir)
    local handle = uv.fs_scandir(dir)
    if not handle then
        return {}
    end

    local entries = {}
    while true do
        local name, t = uv.fs_scandir_next(handle)
        if not name then
            break
        end
        if t == "directory" then
            table.insert(entries, dir .. "/" .. name)
        end
    end

    return entries
end

local function detect_version(path)
    local release = path .. "/release"
    if vim.fn.filereadable(release) == 0 then
        return nil
    end

    for line in io.lines(release) do
        local v = line:match('JAVA_VERSION="(%d+)')
        if v then
            return tonumber(v)
        end
    end

    return nil
end

local function runtime_entry(version, path, is_default)
    return {
        name = "JavaSE-" .. version,
        path = path,
        default = is_default or false,
    }
end

function M.find()
    local runtimes = {}
    local seen = {}

    local function add(path)
        if not path or seen[path] or not is_dir(path) then
            return
        end
        seen[path] = true

        local version = detect_version(path)
        if version then
            table.insert(runtimes, runtime_entry(version, path))
        end
    end

    -- JAVA_HOME
    add(vim.env.JAVA_HOME)

    -- Linux
    for _, p in ipairs(scandir("/usr/lib/jvm")) do
        add(p)
    end

    -- macOS
    for _, p in ipairs(scandir("/Library/Java/JavaVirtualMachines")) do
        add(p .. "/Contents/Home")
    end

    -- Windows
    for _, p in ipairs(scandir("C:/Program Files/Java")) do
        add(p)
    end

    table.sort(runtimes, function(a, b)
        return tonumber(a.name:match("%d+")) > tonumber(b.name:match("%d+"))
    end)

    -- Marca o mais novo como default
    if runtimes[1] then
        runtimes[1].default = true
    end

    return runtimes
end

return M
