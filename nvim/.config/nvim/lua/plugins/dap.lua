-- Debug Adapter Protocol (DAP) plugins
return {
  { "mfussenegger/nvim-dap" },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup({
        close_on_exit = false,
      })

      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end

      local sign = vim.fn.sign_define
      sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
      sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
    end,
  },
}
