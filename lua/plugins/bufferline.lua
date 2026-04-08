return {
  'akinsho/bufferline.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', 'catppuccin' },
  config = function()
    require('bufferline').setup {
      highlights = require('catppuccin.special.bufferline').get_theme(),
      options = {
        diagnostics = 'nvim_lsp',
        separator_style = 'thin',
        offsets = {{
          filetype = 'NvimTree',
          text = 'File Explorer',
          text_align = 'center',
          separator = true
        }},
      },
    }
  end,
}
