local p = _G.packer_plugins
if p and p['mason-lspconfig.nvim'] and p['mason-lspconfig.nvim'].loaded then
  local lsp_config = require ('config.lspconfig')

  -- Note initialization order
  -- https://github.com/williamboman/mason-lspconfig.nvim#setup
  require ("mason").setup()
  require ("mason-lspconfig").setup()
  require("mason-lspconfig").setup_handlers {
    function (server_name)
      require("lspconfig")[server_name].setup {
        on_attach = lsp_config.on_attach,
        flags = lsp_config.flags,
        autostart = true
      }
    end
  }
end
