return {
  { 'Hoffs/omnisharp-extended-lsp.nvim' },
  { 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' },
  { 'Issafalcon/lsp-overloads.nvim' },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'mason-org/mason.nvim', opts = {} },
      { 'mason-org/mason-lspconfig.nvim',
        dependencies = { 'neovim/nvim-lspconfig' },
        opts = {}
      },

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
    },
    config = function()
      require('lsp')
    end,
  },
}
