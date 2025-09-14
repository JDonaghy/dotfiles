-- Main LSP configuration
local on_attach = require('lsp.on_attach').on_attach
local servers = require('lsp.servers').servers

-- Setup neovim lua configuration
require("lazydev").setup({
  library = { "nvim-dap-ui" },
})

local lsp_zero = require('lsp-zero')
lsp_zero.configure('omnisharp', {
  handlers = {
    ["textDocument/definition"] = require('omnisharp_extended').handler,
    ["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler,
    ["textDocument/references"] = require('omnisharp_extended').references_handler,
    ["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
  }
})

require('lspconfig').intelephense.setup({})

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
  if client.server_capabilities.signatureHelpProvider then
    require('lsp-overloads').setup(client, {})
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
