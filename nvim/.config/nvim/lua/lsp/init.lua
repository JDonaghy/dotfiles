-- Main LSP configuration
local on_attach = require('lsp.on_attach').on_attach
local servers = require('lsp.servers').servers

-- Setup neovim lua configuration
require("lazydev").setup({
  library = { "nvim-dap-ui" },
})

local lsp_zero = require('lsp-zero')

lsp_zero.configure('intelephense', {})

lsp_zero.configure('pyright', {})
lsp_zero.configure('ts_ls', {})         -- TypeScript/JavaScript
lsp_zero.configure('rust_analyzer', {}) -- Rust
lsp_zero.configure('html', {})          -- HTML
lsp_zero.configure('cssls', {})         -- CSS
lsp_zero.configure('gopls', {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    },
  },
})

lsp_zero.on_attach(function(client, bufnr)
  require('lsp.on_attach').on_attach(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({ buffer = bufnr })
  if client and client.server_capabilities and client.server_capabilities.signatureHelpProvider then
    require('lsp-overloads').setup(client, {})
  end
  -- Format on save
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function() vim.lsp.buf.format({ async = false }) end,
    })
  end
end)

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config("roslyn", {
  on_attach = function()
    print("This will run when the server attaches!")
  end,
  settings = {
    ["csharp|inlay_hints"] = {
      csharp_enable_inlay_hints_for_implicit_object_creation = true,
      csharp_enable_inlay_hints_for_implicit_variable_types = true,
    },
    ["csharp|code_lens"] = {
      dotnet_enable_references_code_lens = true,
    },
  },
})

vim.lsp.config('helm_ls', {
  settings = {
    yamlls = {
      path = "yaml-language-server",
    },
  },
})

require('config.dap')
