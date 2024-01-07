return {
  'lukas-reineke/headlines.nvim',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  config = function()
    require('headlines').setup()
  end,
  lazy = true,
  ft = { 'markdown', 'orgmode', 'neorg' }
}
