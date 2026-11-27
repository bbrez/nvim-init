return {
  'laytan/cloak.nvim',
  event = 'BufReadPre',
  opts = {
    enabled = true,
    cloak_character = '*',
    patterns = {
      {
        file_pattern = '.env*',
        cloak_pattern = '=.+',
        replace = nil,
      },
    },
  },
  keys = {
    { '<leader>vc', '<cmd>CloakToggle<cr>', desc = 'Toggle Cloak' },
  },
}
