local M = {}
-- https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#c-c-rust-via-lldb-vscode
local find_cmd = (os.getenv('WINDIR') and 'where') or 'command -v'
local lldb_exe = vim.fn.system(find_cmd .. ' lldb-dap')
if string.len(lldb_exe) == 0 then
  lldb_exe = vim.fn.system(find_cmd .. ' lldb-vscode')
end
M.lldb = {
  type = 'executable',
  command = vim.fn.trim(lldb_exe),
  name = 'lldb',
  env = function()
    local variables = {}
    for k, v in pairs(vim.fn.environ()) do
      table.insert(variables, string.format("%s=%s", k, v))
    end
    return variables
  end
}
 return M
