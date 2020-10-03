if vim.bo.filetype ~= 'fsharp' then
  local lsp_config = require ('config.lspconfig')
  local util = require 'lspconfig.util'

  require('lspconfig')['ionide'].setup{
    cmd = { 'fsautocomplete', '--adaptive-lsp-server-enabled' },
    root_dir = util.root_pattern('.git'),
    on_attach = lsp_config.on_attach,
    flags = lsp_config.flags,
    autostart = true
  }
end
