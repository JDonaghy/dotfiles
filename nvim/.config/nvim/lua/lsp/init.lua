-- Main LSP configuration

-- Setup neovim lua configuration
require("lazydev").setup({
  library = { "nvim-dap-ui" },
})

local function on_attach(client, bufnr)
  require('lsp.on_attach').on_attach(client, bufnr)
  -- Default keymaps
  local opts = { buffer = bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  -- Signature help
  if client and client.server_capabilities and client.server_capabilities.signatureHelpProvider then
    require('lsp-overloads').setup(client, {
      keymaps = {},
      ui = {},
      display_automatically = true,
      silent = true,
    })
  end
  -- Format on save
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function() vim.lsp.buf.format({ async = false }) end,
    })
  end
end

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Configure common servers with the same on_attach and capabilities
local servers = { 'intelephense', 'pyright', 'tsserver', 'rust_analyzer', 'cssls' }
for _, server in ipairs(servers) do
  vim.lsp.config(server, {
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

-- Custom server configurations
vim.lsp.config('gopls', {
  on_attach = on_attach,
  capabilities = capabilities,
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

vim.lsp.config('roslyn', {
  on_attach = function(client, bufnr)
    print("Roslyn attached!")
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  settings = {
    ['csharp|inlay_hints'] = {
      csharp_enable_inlay_hints_for_implicit_object_creation = true,
      csharp_enable_inlay_hints_for_implicit_variable_types = true,
    },
    ['csharp|code_lens'] = {
      dotnet_enable_references_code_lens = true,
    },
  },
})

vim.lsp.config('helm_ls', {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    yamlls = {
      path = "yaml-language-server",
    },
  },
})

require('config.dap')
