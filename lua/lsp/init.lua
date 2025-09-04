-- Main LSP configuration
local on_attach = require('lsp.on_attach').on_attach
local servers = require('lsp.servers').servers

-- Setup neovim lua configuration
require("lazydev").setup({
  library = { "nvim-dap-ui" },
})

require('lspconfig').intelephense.setup({})


-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('helm_ls', {
  settings = {
    yamlls = {
        path = "yaml-language-server",
      },
  },
})
