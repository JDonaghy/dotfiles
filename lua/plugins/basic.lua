-- Basic utility plugins that don't require configuration
return {
  -- Detect tabstop and shiftwidth automatically
  { 'tpope/vim-sleuth' },
  { 'will133/vim-dirdiff' },
  { 'kkharji/sqlite.lua' },
  { 'nvim-lua/plenary.nvim' },
  { 'stevearc/dressing.nvim' },
  { 'towolf/vim-helm' }, -- vim syntax for helm templates (yaml + gotmpl + sprig + custom)
  { 'dart-lang/dart-vim-plugin' },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
}