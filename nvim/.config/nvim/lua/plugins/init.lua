-- Main plugins entry point
-- This file automatically imports all plugin modules
return {
  require('plugins.basic'),
  require('plugins.completion'),
  require('plugins.dap'),
  require('plugins.editor'),
  require('plugins.git'),
  require('plugins.languages'),
  require('plugins.lsp'),
  require('plugins.telescope'),
  require('plugins.treesitter'),
  require('plugins.ui'),
}
