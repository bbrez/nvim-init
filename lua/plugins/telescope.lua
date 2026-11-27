return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'folke/noice.nvim',
  },
  cmd = 'Telescope',
  keys = {
    { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
    { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Live grep' },
    { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
    { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Help tags' },
    { '<leader>fr', '<cmd>Telescope oldfiles<cr>', desc = 'Recent files' },
    { '<leader>fn', '<cmd>Telescope noice<cr>', desc = 'Noice messages' },
    { '<leader>fk', '<cmd>Telescope keymaps<cr>', desc = 'Keymaps' },
    { '<leader>f.', '<cmd>Telescope resume<cr>', desc = 'Resume picker' },
    { '<leader>fw', '<cmd>Telescope grep_string<cr>', desc = 'Grep word' },
    { '<leader>fs', '<cmd>Telescope lsp_document_symbols<cr>', desc = 'Document symbols' },
    { '<leader>fv', '<cmd>Telescope colorscheme<cr>', desc = 'Colorschemes' },
  },

  config = function()
    local telescope = require('telescope')
    telescope.setup({})
    pcall(telescope.load_extension, 'noice')
  end,
}
