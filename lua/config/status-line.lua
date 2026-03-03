local M = {}

-- =============================
-- Git Component
-- =============================

local git_cache = {}

local function get_branch()
    local cwd = vim.loop.cwd()

    if not cwd then
        return ""
    end

    if git_cache[cwd] then
        return git_cache[cwd]
    end

    local result = vim.fn.systemlist("git branch --show-current")[1]

    if vim.v.shell_error ~= 0 or not result or result == "" then
        git_cache[cwd] = ""
        return ""
    end

    return result
end

function M.git()
    local branch = get_branch()
    if branch == "" then
        return " " .. "[No Git Branch]" .. " "
    end
    return "  " .. branch .. " "
end

-- =============================
-- Mode
-- =============================

function M.mode()
    local mode = vim.api.nvim_get_mode().mode

    local modes = {
        n = "  NORMAL",
        i = "  INSERT",
        v = " 󰈈 VISUAL",
        V = " 󰈈 V-LINE",
        ["\22"] = " 󰈈 V-BLOCK",
        c = "  COMMAND",
        R = "  REPLACE",
        t = "  TERMINAL",
    }

    return modes[mode] or (" " .. mode)
end

-- =============================
-- File name
-- =============================

function M.filename()
    local bt = vim.bo.buftype
    local name = vim.api.nvim_buf_get_name(0)

    if bt == "help" then
        return " HELP"
    end

    if bt == "quickfix" then
        return " QUICKFIX"
    end

    if name == "" then
        return " [No Name] "
    end

    return " " .. vim.fn.fnamemodify(name, ":.") .. " "
end

-- =============================
-- File Type
-- =============================

function M.filetype()
    local ft = vim.bo.filetype
    local icons = {
        lua = "\u{e620} ", -- nf-dev-lua
        python = "\u{e73c} ", -- nf-dev-python
        javascript = "\u{e74e} ", -- nf-dev-javascript
        typescript = "\u{e628} ", -- nf-dev-typescript
        javascriptreact = "\u{e7ba} ",
        typescriptreact = "\u{e7ba} ",
        html = "\u{e736} ", -- nf-dev-html5
        css = "\u{e749} ", -- nf-dev-css3
        scss = "\u{e749} ",
        json = "\u{e60b} ", -- nf-dev-json
        markdown = "\u{e73e} ", -- nf-dev-markdown
        vim = "\u{e62b} ", -- nf-dev-vim
        sh = "\u{f489} ", -- nf-oct-terminal
        bash = "\u{f489} ",
        zsh = "\u{f489} ",
        rust = "\u{e7a8} ", -- nf-dev-rust
        go = "\u{e724} ", -- nf-dev-go
        c = "\u{e61e} ", -- nf-dev-c
        cpp = "\u{e61d} ", -- nf-dev-cplusplus
        java = "\u{e738} ", -- nf-dev-java
        php = "\u{e73d} ", -- nf-dev-php
        ruby = "\u{e739} ", -- nf-dev-ruby
        swift = "\u{e755} ", -- nf-dev-swift
        kotlin = "\u{e634} ",
        dart = "\u{e798} ",
        elixir = "\u{e62d} ",
        haskell = "\u{e777} ",
        sql = "\u{e706} ",
        yaml = "\u{f481} ",
        toml = "\u{e615} ",
        xml = "\u{f05c} ",
        dockerfile = "\u{f308} ", -- nf-linux-docker
        gitcommit = "\u{f418} ", -- nf-oct-git_commit
        gitconfig = "\u{f1d3} ", -- nf-fa-git
        vue = "\u{fd42} ", -- nf-md-vuejs
        svelte = "\u{e697} ",
        astro = "\u{e628} ",
    }

    if ft == "" then
        return " \u{f15b} " -- nf-fa-file_o
    end

    return ((icons[ft] or " \u{f15b} ") .. ft)
end

-- =============================
-- File Size (buffer-based)
-- =============================

function M.filesize()
    local line_count = vim.api.nvim_buf_line_count(0)
    local size = vim.api.nvim_buf_get_offset(0, line_count)

    if not size or size <= 0 then
        return ""
    end

    if size < 1024 then
        return string.format(" %dB ", size)
    elseif size < 1024 * 1024 then
        return string.format(" %.1fK ", size / 1024)
    else
        return string.format(" %.1fM ", size / 1024 / 1024)
    end
end

-- =============================
-- LSP
-- =============================

function M.lsp()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients == 0 then
        return "[No LSP]" .. " "
    end

    local names = {}
    local copilot_enabled = false
    for _, client in ipairs(clients) do
        if client.name == "GitHub Copilot" then
            copilot_enabled = true
        else
            table.insert(names, client.name)
        end
    end

    local lsp_text = ""
    if #names > 0 then
        lsp_text = "  " .. names[1]
        if #names > 1 then
            lsp_text = lsp_text .. " (+" .. (#names - 1) .. ")"
        end

        if copilot_enabled then
            lsp_text = lsp_text .. " • " .. "\u{f4b8}"
        end
    end

    return lsp_text .. " • "
end

-- =============================
-- Diagnostics Count (E/W/I/H)
-- =============================

function M.diagnostics()
    local bufnr = 0

    local d = vim.diagnostic.count(bufnr)

    if not d then
        return ""
    end

    local errors = d[vim.diagnostic.severity.ERROR] or 0
    local warns = d[vim.diagnostic.severity.WARN] or 0
    local infos = d[vim.diagnostic.severity.INFO] or 0
    local hints = d[vim.diagnostic.severity.HINT] or 0

    if errors + warns + infos + hints == 0 then
        return ""
    end

    local parts = {}

    table.insert(parts, "•")

    if errors > 0 then
        table.insert(parts, "%#DiagnosticError#  " .. errors .. "%*")
    end
    if warns > 0 then
        table.insert(parts, "%#DiagnosticWarn#  " .. warns .. "%*")
    end
    if infos > 0 then
        table.insert(parts, "%#DiagnosticInfo#  " .. infos .. "%*")
    end
    if hints > 0 then
        table.insert(parts, "%#DiagnosticHint#  " .. hints .. "%*")
    end

    return table.concat(parts, "")
end

-- =============================
-- Setup
-- =============================

function M.setup()
    vim.api.nvim_create_autocmd({ "DirChanged", "FocusGained" }, {
        callback = function()
            git_cache = {}
            vim.cmd("redrawstatus")
        end,
    })

    -- Avoid multiple requires
    _G.sl = M

    vim.o.statusline = table.concat({
        " %{v:lua.sl.mode()} ",
        "",
        "%{v:lua.sl.filename()}",
        "",
        "%{v:lua.sl.git()}",
        "%{%v:lua.sl.diagnostics()%}",
        -- "",
        -- " %{v:lua.sl.filetype()} ",
        "%=",
        "%{v:lua.sl.lsp()}",
        "%{v:lua.sl.filesize()}",
        "•",
        " %l:%c %P ",
    })
end

return M
