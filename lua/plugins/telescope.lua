-- Telescope (fuzzy finder) configuration
return {
  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x',
     dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'jonarrien/telescope-cmdline.nvim' },
      { 'nvim-telescope/telescope-live-grep-args.nvim', version = "^1.0.0", },
      config = function()
        require("telescope").load_extension("live_grep_args")
        require('telescope').load_extension('smart_history')
      end
    },
    keys = {
      { '<Leader>;', '<cmd>Telescope cmdline<cr>', desc = 'Cmdline' }
    },
    opts = {
      extensions = {
        cmdline = {
          picker = {
            layout_config = {
              width  = 120,
              height = 25,
            }
          },
          mappings    = {
            complete      = '<Tab>',
            run_selection = '<C-CR>',
            run_input     = '<CR>',
          },
        },
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension('cmdline')
      
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        defaults = {
          history = {
            path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
            limit = 100,
          },
          mappings = {
            i = {
              ["<C-Down>"] = require("telescope.actions").cycle_history_next,
              ["<C-Up>"] = require("telescope.actions").cycle_history_prev
            },
          },
        },
      }

      -- Enable telescope fzf native, if installed
      pcall(require('telescope').load_extension, 'fzf')
    end,
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    config = function()
      return vim.fn.executable 'make' == 1
    end,
  },
}