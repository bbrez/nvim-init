return {
  'akinsho/bufferline.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', 'catppuccin' },
  config = function()
    require('bufferline').setup {
      highlights = require('catppuccin.groups.integrations.bufferline').get(),
      options = {
        diagnostics = 'nvim_lsp',
        separator_style = 'slant',
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
