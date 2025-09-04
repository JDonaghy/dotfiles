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

local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,

  ["bicep"] = function ()
    require('lspconfig').bicep.setup {
      cmd = { 'dotnet', '/home/jdonaghy/.local/share/nvim/mason/packages/bicep-lsp/extension/bicepLanguageServer/Bicep.LangServer.dll' },
    }
  end,

  ["rust_analyzer"] = function ()
    local rt = require("rust-tools")
    rt.setup({
      server = {
        on_attach = function(_, bufnr)
          -- Hover actions
          vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
          -- Code action groups
          vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
      },
    })
  end,

  ['helm_ls'] = function ()
    require('lspconfig').helm_ls.setup {
      yamlls = {
        path = "yaml-language-server",
      }
    }
  end,
}