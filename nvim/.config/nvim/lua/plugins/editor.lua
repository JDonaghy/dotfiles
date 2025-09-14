-- Editor enhancement plugins
return {
  { 'kevinhwang91/nvim-ufo',
    dependencies = {'kevinhwang91/promise-async'},
    config = function()
      require('ufo').setup({
          provider_selector = function(bufnr, filetype, buftype)
              return {'treesitter', 'indent'}
          end
      })
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    end
  },

  {
    "gbprod/yanky.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

  { 'nvim-pack/nvim-spectre',
      config = function()
        require('spectre').setup()
      end
  },

  {'voldikss/vim-floaterm',
    config = function()
      local set = vim.keymap.set
      set('n', '<Leader>tf', '<Cmd>FloatermToggle!<CR>')
    end,
  },

  {
  'rmagatti/auto-session',
    lazy = false,
    config = function()
      require("auto-session").setup{
        -- log_level = 'debug',
        args_allow_files_auto_save = true
      }
    end
  },

  {'akinsho/toggleterm.nvim', version = "*",
    config = function()
      require("toggleterm").setup{
        open_mapping = [[<c-\>]]
      }

      local Terminal  = require('toggleterm.terminal').Terminal
    end,
  },

  {'stevearc/overseer.nvim',
    opts = {},
    config = function()
      require('overseer').setup({
        strategy = {
          "toggleterm",
          -- load your default shell before starting the task
          use_shell = false,
          -- overwrite the default toggleterm "direction" parameter
          direction = nil,
          -- overwrite the default toggleterm "highlights" parameter
          highlights = nil,
          -- overwrite the default toggleterm "auto_scroll" parameter
          auto_scroll = nil,
          -- have the toggleterm window close and delete the terminal buffer
          -- automatically after the task exits
          close_on_exit = false,
          -- have the toggleterm window close without deleting the terminal buffer
          -- automatically after the task exits
          -- can be "never, "success", or "always". "success" will close the window
          -- only if the exit code is 0.
          quit_on_exit = "never",
          -- open the toggleterm window when a task starts
          open_on_start = true,
          -- mirrors the toggleterm "hidden" parameter, and keeps the task from
          -- being rendered in the toggleable window
          hidden = false,
          -- command to run when the terminal is created. Combine with `use_shell`
          -- to run a terminal command before starting the task
          on_create = nil,
        }
      })
    end,
  },
}
