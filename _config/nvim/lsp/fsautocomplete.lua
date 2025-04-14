local fsac_get_root_dir = function(bufnr, callback)
  local cwd = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
  local proj_root = vim.fs.root(cwd, function(name, path)
      local is_dotnet_proj = (name:match('%.sln$') or name:match('%.fsproj$')) ~= nil
      local is_repo = (name:match('^%.git') or name:match('^%.hg') or name:match('^%.svn')) ~= nil
      local is_fsharp_file = name:match('%.fs[ix]?$') ~= nil
      return (is_dotnet_proj or is_repo or is_fsharp_file)
    end)
  callback(proj_root)
end

local fsac_is_client_reusable = function(client, config)
    local workspace = client.settings.workspace or {}
    return (config.root_dir == client.root_dir or next(workspace))
end

return {
  cmd = {
    vim.fs.joinpath(os.getenv('USERPROFILE') or os.getenv('HOME'), '.dotnet/tools/fsautocomplete'),
    '--adaptive-lsp-server-enabled'
  },
  cmd_env = {
    DOTNET_ROLL_FORWARD = "LatestMinor",
    MONO_MANAGED_WATCHER = "disabled"
  },
  init_options = {
    AutomaticWorkspaceInit = true
  },
  settings = {
    FSharp = {
      AbstractClassStubGeneration = true,
      AbstractClassStubGenerationMethodBody = 'failwith "Not Implemented"',
      AbstractClassStubGenerationObjectIdentifier = 'this',
      AddPrivateAccessModifier = false,
      DisableInMemoryProjectReferences = false,
      EnableAnalyzers = true,
      EnableReferenceCodeLens = false,
      ExternalAutocomplete = false,
      FullNameExternalAutocomplete = false,
      GenerateBinlog = false,
      IndentationSize = 4,
      InterfaceStubGeneration = true,
      Linter = true,
      RecordStubGeneration = true,
      ResolveNamespaces = true,
      SimplifyNameAnalyzer = false,
      UnionCaseStubGeneration = true,
      UnnecessaryParenthesesAnalyzer = false,
      UnusedDeclarationsAnalyzer = false,
      UnusedOpensAnalyzer = true,
      UseSdkScripts = true,
      WorkspaceModePeekDeepLevel = 2,
      fsiExtraInteractiveParameters = { "--readline-", "--shadowcopyreferences+" },
      keywordsAutocomplete = true
    }
  },
  handlers = {
    ['fsharp/notifyWorkspace'] = function(err, result, ctx)
      if result then
        local client = vim.lsp.get_client_by_id(ctx.client_id)
        local loaded = client.config.settings.workspace or {}
        local data = vim.json.decode(result.content)
        if data.Kind == 'projectLoading' then
          local proj = vim.fs.normalize(data.Data.Project)
          print(client.name .. ': Loading ' .. proj)
          loaded[vim.fs.basename(proj)] = proj
          client.config.settings.workspace = loaded
        elseif data.Kind == 'workspaceLoad' and data.Data.Status == 'finished' then
          local projs = vim.iter(loaded):fold(0, function(c,_,_) return c+1 end)
          print(client.name .. string.format(': Finished loading %d project(s)', projs))
          client:notify(
            vim.lsp.protocol.Methods.workspace_didChangeConfiguration,
            { settings = client.config.settings }
          )
        end
      end
      return { result, err }
    end
  },
  root_dir = fsac_get_root_dir,
  reuse_client = fsac_is_client_reusable,
  filetypes = { 'fsharp' }
}
