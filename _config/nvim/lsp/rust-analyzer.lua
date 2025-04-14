return {
  cmd = { 'rust-analyzer' },
  settings = {
    checkOnSave = false,
    check = {
      command = "clippy",
      extraArgs = { "--no-deps" }
    }
  },
  root_markers = { 'Cargo.toml' },
  filetypes = { 'rust' }
}
