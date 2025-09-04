-- [[ Basic Keymaps ]]

-- Set leader keys
vim.g.mapleader = ' '
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

-- Telescope keymaps
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

-- UFO (code folding) keymaps
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)