-- Main LSP configuration
local on_attach = require('lsp.on_attach').on_attach
local servers = require('lsp.servers').servers

-- Setup neovim lua configuration
require("lazydev").setup({
  library = { "nvim-dap-ui" },
})

local lsp_zero = require('lsp-zero')

lsp_zero.configure('roslyn', {
  -- Optional: add any custom settings here
})

-- lsp_zero.configure('omnisharp', {
--   handlers = {
--     ["textDocument/definition"] = require('omnisharp_extended').handler,
--     ["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler,
--     ["textDocument/references"] = require('omnisharp_extended').references_handler,
--     ["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
--   },
--   enable_editorconfig_support = true,  -- Respect .editorconfig files
--   enable_roslyn_analyzers = true,      -- Use Roslyn analyzers for advanced diagnostics
--   organize_imports_on_format = true,   -- Organize usings on format
--   enable_import_completion = true,     -- Enable completion for unimported types
--   analyze_open_documents_only = false, -- Analyze whole project, not just open files
-- })
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

vim.lsp.config('helm_ls', {
  settings = {
    yamlls = {
      path = "yaml-language-server",
    },
  },
})

require('config.dap')
