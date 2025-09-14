-- Language-specific plugins
return {
  { 'simrat39/rust-tools.nvim' },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    config = true,
    event = "VeryLazy",
  },
  {
    'akinsho/flutter-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',
    },
    config = function ()
      local map = vim.keymap.set
      map("n", "fR", "<cmd> FlutterRun <cr>")
      map("n", "fd", "<cmd> FlutterDevices <cr>")
      map("n", "fr", "<cmd> FlutterRestart <cr>")
      map("n", "fo", "<cmd> FlutterOutlineToggle <cr>")
      require("flutter-tools").setup({
        decorations = {
          statusline = {
            app_version = true,
            device = true,
          },
        },
        widget_guides = {
          enabled = true,
        },
        closing_tags = {
          highlight = 'Comment',
          prefix = '//',
          enabled = true,
        },
        lsp = {
          on_attach = require('lsp.on_attach').on_attach,
          color = {
            enabled = true,
            background = true,
            foreground = false,
            virtual_text = true,
            virtual_text_str = "■",
          },
          settings = {
            showTodos = true,
            completeFunctionCalls = true,
            enableSnippets = true,
          },
        },
        debugger = {
          enabled = true,
          run_via_dap = true,
          exception_breakpoints = {},
          register_configurations = function(_)
            require('dap').configurations.dart = {
              {
                    type = "dart",
                    request = "launch",
                    name = "Launch",
                    cwd = "${workspaceFolder}",
                    program = "${workspaceFolder}/lib/main.dart",
                    debugSdkLibraries = false,
                    debugExternalPackageLibraries = false,
              },
            }
          end,
        },
      })
    end,
    ft = "dart"
  },

  {
    "ray-x/go.nvim",
    dependencies = {  -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    enabled = not _G.IS_WSL,
    config = function()
      require("go").setup()
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },

  {"ellisonleao/glow.nvim",
    config = function()
      require('glow').setup({
        install_path = "/home/linuxbrew/.linuxbrew/bin/glow",
      })
    end,
    cmd = "Glow"
  },
}
