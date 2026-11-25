-- headlines.nvim is archived/unmaintained; kept for markdown UX until a replacement is chosen.
return {
  'lukas-reineke/headlines.nvim',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  ft = { 'markdown', 'orgmode', 'neorg' },
  config = function()
    require('headlines').setup()
  end,
}
