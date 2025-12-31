return {
  {
    "github/copilot.vim",
    event = "VeryLazy",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.keymap.set('i', '<S-Tab>', 'copilot#Accept("\\<S-Tab>")', { expr = true, replace_keycodes = false })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    config = function()
      CopilotChat = require("CopilotChat")
      CopilotChat.setup({
        model = 'gpt-4.1',
        temperature = 0.1, -- Lower = focused, higher = creative

        window = {
          layout   = "float",
          relative = "editor",
          width    = math.floor(vim.o.columns * 0.3),
          height   = math.floor(vim.o.lines),
          row      = 1,
          col      = vim.o.columns - math.floor(vim.o.columns * 0.3),
          border   = "rounded",
          title    = "Copilot Chat",
        },
      })
    end,
  },
}
