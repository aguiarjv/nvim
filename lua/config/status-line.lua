local M = {}

-- =============================
-- Git Component
-- =============================

local branch_cache = {}

local function get_git_branch(bufnr)
    bufnr = bufnr or 0

    local cwd = vim.api.nvim_buf_get_name(bufnr)
    if cwd == "" then
        return ""
    end

    local dir = vim.fs.dirname(cwd)
    local git_dir = vim.fs.find(".git", {
        path = dir,
        upward = true,
        type = "directory",
    })[1]

    if not git_dir then
        branch_cache[bufnr] = ""
        return ""
    end

    if branch_cache[bufnr] then
        return branch_cache[bufnr]
    end

    local head_path = git_dir .. "/HEAD"
    local f = io.open(head_path, "r")
    if not f then
        return ""
    end

    local head = f:read("*l")
    f:close()

    local branch = head and head:match("ref: refs/heads/(.+)") or ""
    branch_cache[bufnr] = branch or ""

    return branch_cache[bufnr]
end

function M.git()
    local branch = get_git_branch(0)
    if branch == "" then
        return "[No git branch]"
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
        return " [No Name]"
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

local lsp_status = {
    active = false,
    name = "",
}

function M.lsp()
    if lsp_status.active and lsp_status.name ~= "" then
        return "  " .. lsp_status.name .. " "
    end

    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients > 0 then
        return "  " .. clients[1].name .. " "
    end

    return ""
end

-- =============================
-- Setup
-- =============================

function M.setup()
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "DirChanged", "FocusGained" }, {
        callback = function(args)
            branch_cache[args.buf] = nil
        end,
    })

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client then
                lsp_status.active = true
                lsp_status.name = client.name
                vim.cmd("redrawstatus")
            end
        end,
    })

    vim.api.nvim_create_autocmd("LspDetach", {
        callback = function()
            lsp_status.active = false
            lsp_status.name = ""
            vim.cmd("redrawstatus")
        end,
    })

    vim.o.statusline = table.concat({
        " %{v:lua.require'config.status-line'.mode()} ",
        "",
        "%{v:lua.require'config.status-line'.git()}",
        "",
        "%{v:lua.require'config.status-line'.filename()}",
        -- "",
        -- " %{v:lua.require'config.status-line'.filetype()} ",
        "",
        "%{v:lua.require'config.status-line'.lsp()}",
        "%=",
        "%{v:lua.require'config.status-line'.filesize()}",
        " %l:%c %P ",
    })
end

return M
