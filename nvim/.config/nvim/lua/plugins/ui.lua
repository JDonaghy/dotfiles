-- UI and appearance plugins
return {
  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    main = 'ibl',
    opts = {},
    config = function()
      require('ibl').setup()
    end
  },

  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    config = function()
      require("barbecue").setup({
        create_autocmd = false, -- prevent barbecue from updating itself automatically
      })
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local api = require "nvim-tree.api"
      require("nvim-tree").setup {
        update_focused_file = {
          enable = true,
        },
        git = {
          ignore = false,
        },
        renderer = {
          highlight_git = true, -- Highlights files/folders with git status colors
          icons = {
            show = {
              git = true,          -- Shows git status icons (A/M/D/untracked, etc.)
              folder = true,       -- Shows folder icons
              file = true,         -- Shows file icons
              folder_arrow = true, -- Shows arrows for expandable folders
            },
          },
        },
      }
      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, noremap = true, silent = true, nowait = true }
      end
      vim.keymap.set('n', '<leader>tt', api.tree.toggle, opts('Toggle Tree'))
    end,
  },

  {
    'PhilRunninger/bufselect',
    init = function()
      vim.api.nvim_set_keymap('n', '<Space>bv', '<Cmd>ShowBufferList<CR>', { noremap = true, silent = true })
    end,
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require 'colorizer'.setup({
        '*',                -- Highlight all files, but customize some others.
        css = { rgb_fn = true, }, -- Enable parsing rgb(...) functions in css.
        html = { names = false, } -- Disable parsing "names" like Blue or Gray
      })
    end,
  },
}
