return {
  cmd = { 'clangd', '--background-index' },
  flags = {
    debounce_text_changes = 20
  },
  root_markers = { '.clangd', '.clang-tidy', 'compile_commands.json', 'compile_flags.txt' },
  filetypes = { 'c', 'cpp' }
}
