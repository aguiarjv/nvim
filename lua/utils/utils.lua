local M = {}

-- Verifica se um plugin está carregado no Lazy
function M.has(name)
  local ok, lazy_config = pcall(require, 'lazy.core.config')
  return ok and lazy_config.plugins[name] ~= nil
end

-- Pega a configuração crua do LSP, como usada por LazyVim.lsp.get_raw_config
function M.get_lsp_raw_config(server_name)
  local ok, config = pcall(require, 'lspconfig.server_configurations.' .. server_name)
  if not ok then
    vim.notify("LSP config for '" .. server_name .. "' not found.", vim.log.levels.WARN)
    return {}
  end
  return config.default_config or {}
end

-- Merge profundo de tabelas, com sobrescrita (como extend_or_override do LazyVim)
function M.extend_or_override(defaults, overrides)
  return vim.tbl_deep_extend('force', defaults or {}, overrides or {})
end

-- LSP capabilities com suporte ao cmp-nvim-lsp
function M.capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local ok, cmp = pcall(require, 'cmp_nvim_lsp')
  if ok then
    capabilities = cmp.default_capabilities(capabilities)
  end
  return capabilities
end

return M
