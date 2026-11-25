return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  config = function()
    require('catppuccin').setup({
      flavour = 'mocha',
      integrations = {
        nvimtree = true,
        telescope = true,
        which_key = true,
        noice = true,
        notify = true,
        aerial = true,
        treesitter = true,
        indent_blankline = { enabled = true },
      },
    })

    vim.cmd.colorscheme('catppuccin')
  end,
}
