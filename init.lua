require('bbrez.set')
require('bbrez.remap')
require('bbrez.lazy')

if vim.g.neovim then
  require('bbrez.graphical')
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'<filetype>'},
  callback = function()
    vim.treesitter.start() 
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

