-- https://neovim.io/doc/user/lsp.html#lsp-config
if vim.version().minor < 11 then
  error("-- `vim.lsp.config`, etc. requires v0.11.0 or newer.", 2)
end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local bufopts = { noremap=true, silent=true, buffer=ev.buf }
    -- See `:help vim.[lsp,diagnostic].*` for documentation on any of the below functions
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
    vim.keymap.set('n', '[k', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gv', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, bufopts)
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>td', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)

    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)

    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, bufopts)

    vim.api.nvim_create_autocmd({'BufUnload'}, {
      callback = function(args)
        if vim.lsp.buf_is_attached(args.buf, client.id) then
          vim.lsp.buf_detach_client(args.buf, client.id)
        end
        if not next(client.attached_buffers) then
          client:stop()
        end
      end
    })

    -- vim.api.nvim_create_autocmd({'CursorHold', 'InsertLeave'}, {
      -- callback = function(args)
        -- vim.lsp.buf.hover({ focus = false })
      -- end
    -- })

    if client:supports_method('textDocument/completion') then
      local blink_cmp_loaded, cmp = pcall(require, 'blink.cmp')
      if blink_cmp_loaded then
        -- redundant, at least for blink.cmp?
        -- https://github.com/neovim/nvim-lspconfig/issues/3728#issuecomment-2824563975
        local caps = client.capabilities
        client.capabilities = cmp.get_lsp_capabilities(caps)
      else -- https://neovim.io/doc/user/lsp.html#lsp-attach
        local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
        client.server_capabilities.completionProvider.triggerCharacters = chars
        vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
      end
      vim.o.winborder = 'rounded'
    end
  end
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, { focusable = false }
)

vim.diagnostic.config({
  virtual_text = { current_line = true }
})
