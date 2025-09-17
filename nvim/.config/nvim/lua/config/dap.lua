local dap = require('dap')

local function find_first_csproj()
  local handle = io.popen("find . -name '*.csproj' | grep -vi test | head -n 1")
  local result = handle:read("*a")
  handle:close()
  return vim.fn.trim(result)
end

dap.set_log_level('TRACE')

dap.adapters.coreclr = {
  type = 'executable',
  command = os.getenv("HOME") .. '/.local/bin/netcoredbg',
  args = { '--interpreter=vscode' }
}

dap.adapters.coreclrdbg = {
  type = 'server',
  host = 'localhost',
  port = 4711
}

dap.configurations.cs = {
  {
    type = 'coreclrdbg',
    name = 'Attach to Docker (.NET)',
    request = 'attach',
    justMyCode = false,
    processId = function()
      return vim.fn.input('Enter process ID to attach: ')
    end,
  },
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
      local csproj_dir = vim.fn.fnamemodify(csproj, ":h")
      local csproj_name = vim.fn.fnamemodify(csproj, ":t")
      local build_cmd = "cd " .. csproj_dir .. " && dotnet build " .. vim.fn.shellescape(csproj_name)
      print("Build command: " .. build_cmd)
      local build_output = vim.fn.system(build_cmd)
      print(build_output)
      if vim.v.shell_error ~= 0 then
        error("Build failed!")
      end
      local dll_pattern = csproj:gsub("[^/\\]+%.csproj$", "") .. "bin/Debug/net*/" .. dll_name .. ".dll"
      local dll_matches = vim.fn.glob(dll_pattern, false, true)
      local dll_path = dll_matches[1] and vim.fn.fnamemodify(dll_matches[1], ":p") or ""
      return vim.fn.input('Path to dll: ', dll_path, 'file')
    end,
    cwd = function()
      local csproj = find_first_csproj()
      return vim.fn.fnamemodify(csproj, ":h")
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
vim.keymap.set('n', '<F5>', function() require 'dap'.continue() end)
vim.keymap.set('n', '<F9>', function() require 'dap'.toggle_breakpoint() end)
vim.keymap.set('n', '<F10>', function() require 'dap'.step_over() end)
vim.keymap.set('n', '<F11>', function() require 'dap'.step_into() end)
vim.keymap.set('n', '<S-F11>', function() require 'dap'.step_out() end)
vim.keymap.set('n', '<S-F5>', function() require 'dap'.terminate() end)
vim.keymap.set('n', '<C-S-F5>', function() require 'dap'.restart() end)
