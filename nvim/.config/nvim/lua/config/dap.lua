local dap = require('dap')

local function find_first_csproj()
  local handle = io.popen("find . -name '*.csproj' | head -n 1")
  local result = handle:read("*a")
  handle:close()
  return vim.fn.trim(result)
end

dap.adapters.coreclr = {
  type = 'executable',
  command = os.getenv("HOME") .. '/.local/bin/netcoredbg',
  args = {'--interpreter=vscode'}
}

dap.configurations.cs = {
  {
    type = 'coreclr',
    name = 'launch - netcoredbg',
    request = 'launch',
    program = function()
      local csproj = find_first_csproj()
      if csproj == "" then
        error("No .csproj file found!")
      end
      local dll_name = csproj:match("([^/\\]+)%.csproj$")
      local dll_path = csproj:gsub("[^/\\]+%.csproj$", "") .. "bin/Debug/net8.0/" .. dll_name .. ".dll"
      return vim.fn.input('Path to dll: ', dll_path, 'file')
    end,
  },
}

dap.adapters.python = {
  type = 'executable',
  command = '${workspaceFolder}/venv/bin/python',
  args = { '-m', 'debugpy.adapter' },
}
dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = "Launch file",
    program = "${file}",
    justMyCode = false,
  },
}


dap.adapters.python = {
  type = 'executable',
  command = 'python',
  args = { '-m', 'debugpy.adapter' },
}

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',
    pythonPath = function()
      return vim.fn.input('Path to python: ', 'python', 'file')
    end,
  },
}

-- VS Code-like keymaps for nvim-dap
vim.keymap.set('n', '<F5>', function() require'dap'.continue() end)
vim.keymap.set('n', '<F9>', function() require'dap'.toggle_breakpoint() end)
vim.keymap.set('n', '<F10>', function() require'dap'.step_over() end)
vim.keymap.set('n', '<F11>', function() require'dap'.step_into() end)
vim.keymap.set('n', '<S-F11>', function() require'dap'.step_out() end)
vim.keymap.set('n', '<S-F5>', function() require'dap'.terminate() end)
vim.keymap.set('n', '<C-S-F5>', function() require'dap'.restart() end)
