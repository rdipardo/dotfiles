local loaded, builtin = pcall(require, 'telescope.builtin')
if loaded then
  -- https://github.com/nvim-telescope/telescope.nvim#usage
  vim.keymap.set('n', '<Space>ff', builtin.find_files, { desc = 'Telescope find files' })
  vim.keymap.set('n', '<Space>fg', builtin.live_grep, { desc = 'Telescope live grep' })
  vim.keymap.set('n', '<Space>fb', builtin.buffers, { desc = 'Telescope buffers' })
  vim.keymap.set('n', '<Space>fh', builtin.help_tags, { desc = 'Telescope help tags' })
end
