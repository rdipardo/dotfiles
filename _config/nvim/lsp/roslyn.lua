-- install rosyln via script, e.g.,
-- https://github.com/dbittencourt/dotfiles/blob/main/scripts/install-roslyn.sh
local roslyn_version = '5.0.0-1.25273.4'
local machine_id = (vim.fn.has('win64') == 1 and 'win-x64') or 'linux-x64'

local roslyn_get_root_dir = function(bufnr, callback)
  local cwd = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
  local proj_root = vim.fs.root(cwd, function(name, path)
      local is_dotnet_proj = (name:match('%.sln$') or name:match('%.csproj$')) ~= nil
      local is_repo = (name:match('^%.git') or name:match('^%.hg') or name:match('^%.svn')) ~= nil
      return (is_dotnet_proj or is_repo)
    end)
  callback(proj_root)
end

return {
  settings = {
      ['csharp|background_analysis'] = {
        dotnet_analyzer_diagnostics_scope = 'fullSolution',
        dotnet_compiler_diagnostics_scope = 'fullSolution',
      },
      ['csharp|code_lens'] = {
        dotnet_enable_references_code_lens = true,
        dotnet_enable_tests_code_lens = true,
      },
      ["csharp|inlay_hints"] = {
        dotnet_show_completion_items_from_unimported_namespaces = true,
        dotnet_show_name_completion_suggestions = true,
        dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
        dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
      },
      ["csharp|symbol_search"] = {
        dotnet_search_reference_assemblies = true,
      }
  },
  -- get binaries from:
  -- https://dev.azure.com/azure-public/vside/_artifacts/feed/vs-impl/NuGet/Microsoft.CodeAnalysis.LanguageServer
  cmd = {
      "dotnet",
      vim.fs.joinpath(
        vim.fs.joinpath(os.getenv('USERPROFILE') or os.getenv('HOME'), '.nuget/packages/Microsoft.CodeAnalysis.LanguageServer'),
        roslyn_version..'/content/LanguageServer/' .. machine_id..'/Microsoft.CodeAnalysis.LanguageServer.dll'),
      "--logLevel=Information",
      "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
      "--stdio",
  },
  root_dir = roslyn_get_root_dir,
  filetypes = { 'cs' }
}
