local dotnet_tool_dir = vim.fs.root(0, function(name, path)
  return name:match('%.config$') ~= nil
end)

if dotnet_tool_dir then
  local config_file = vim.fs.joinpath(dotnet_tool_dir, '.config', 'dotnet-tools.json')
  if vim.uv.fs_stat(config_file) ~= nil then
    local config = vim.json.decode(table.concat(vim.fn.readfile(config_file)))
    if config.tools and config.tools.fsautocomplete then
      vim.lsp.config('fsautocomplete',
        { cmd = { 'dotnet', 'fsautocomplete', '--adaptive-lsp-server-enabled' } }
      )
    end
  end
end

vim.lsp.enable({ 'fsautocomplete' })
