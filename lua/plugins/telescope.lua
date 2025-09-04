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
      local builtin = require('telescope.builtin')
    

      vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
      vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
      vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sb', require("telescope.builtin").buffers, { desc = '[S]earch [B]uffers ' })
      vim.keymap.set('n', '<leader>sc', require("telescope.builtin").commands, { desc = '[S]earch [C]ommands ' })
      vim.keymap.set('n', '<leader>st', require("telescope.builtin").treesitter, { desc = '[S]earch [T]reesitter ' })
      vim.keymap.set('n', '<leader>ss', require("telescope.builtin").current_buffer_fuzzy_find, { desc = '[S]earch [s]search ' })
      vim.keymap.set('n', '<leader>sr', require("telescope").extensions.live_grep_args.live_grep_args, { noremap = true, desc = '[S]earch current [R]ipgrep ' })

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
