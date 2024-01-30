return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local t = require('telescope')
    t.setup{}

    t.load_extension('noice')
  end,
  lazy = true,
  cmd = 'Telescope',
}
