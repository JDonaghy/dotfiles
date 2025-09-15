vim.g.mapleader = ' '
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostics' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostics to loclist' })
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Search highlighting keymaps
vim.keymap.set('n', '<leader>h', '<Cmd>set hlsearch<CR>', { desc = 'Enable Search highlighting' })
vim.keymap.set('n', '<leader>H', '<Cmd>set hlsearch!<CR>', { desc = 'Diable Search highlighting' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- <ctrl-s> to Save
vim.keymap.set({ "n", "v", "i" }, "<C-S>", "<C-c>:update<cr>", { silent = true, desc = "Save" })

-- Yanky keymaps
vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({"n","x"}, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({"n","x"}, "gP", "<Plug>(YankyGPutBefore)")

vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)")

-- Dart/Flutter keymaps
vim.keymap.set('n', '<leader>ff', ':FlutterRun<CR>')
vim.keymap.set('n', '<leader>fq', ':FlutterQuit<CR>')
vim.keymap.set('n', '<leader>fr', ':FlutterReload<CR>')
vim.keymap.set('n', '<leader>fR', ':FlutterRestart<CR>')

-- DAP (Debug Adapter Protocol) keymaps
vim.keymap.set('n', '<leader>db', ':lua require("dap").toggle_breakpoint()<CR>')
vim.keymap.set('n', '<leader>dB', ':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint Condition: "))<CR>')
vim.keymap.set('n', '<leader>dd', ':lua require("dap").continue()<CR>')
vim.keymap.set('n', '<leader>do', ':lua require("dap").step_over()<CR>')
vim.keymap.set('n', '<leader>di', ':lua require("dap").step_ito()<CR>')

-- Python VirtualEnv keymaps
vim.keymap.set("n", "<leader>vs", "<cmd>VenvSelect<cr>", { desc = "Select VirtualEnv" })
