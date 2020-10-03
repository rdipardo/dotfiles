local loaded, surround = pcall(require, 'mini.surround')
if loaded then
  surround.setup({})
else
  -- Surround with quote: https://stackoverflow.com/a/2148055
  vim.api.nvim_set_keymap('n', 'qw',  [[ciw'<C-r>"'<Esc>]], {noremap = true})
  vim.api.nvim_set_keymap('n', 'qqw', [[ciw"<C-r>""<Esc>]], {noremap = true})
  vim.api.nvim_set_keymap('n', 'sw',  [[ciw(<C-r>")<Esc>]], {noremap = true})
  vim.api.nvim_set_keymap('n', 'swb', [[ciw[<C-r>"]<Esc>]], {noremap = true})
  vim.api.nvim_set_keymap('n', 'swr', [[ciw{<C-r>"}<Esc>]], {noremap = true})
end
