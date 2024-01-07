return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  config = function()
    require('notify').setup({
      timeout = 500
   })

    require('noice').setup({
      presets = {
        bottom_search = true,
        command_palette = true,
        lsp_doc_border = true,
      }
    })
  end,
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify'
  }
}
