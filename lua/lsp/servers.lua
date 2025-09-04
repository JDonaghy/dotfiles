-- LSP server configurations
local M = {}

-- Server settings
M.servers = {
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
  omnisharp = {
    filetypes = { 'cs', 'csx' },
  }
}

return M