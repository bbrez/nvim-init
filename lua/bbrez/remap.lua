vim.keymap.set('n', '<leader>wh', ':split<CR>', {
  noremap = true,
  silent = true,
  desc =  'Horizontal Split'
})

vim.keymap.set('n', '<leader>wv', ':vsplit<CR>', {
  noremap = true,
  silent = true,
  desc = 'Vertical Split'
})

vim.keymap.set('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Tab>', ':bprev<CR>', { noremap = true, silent = true })

vim.keymap.set('i', 'jj', '<ESC>', { noremap = true, silent = true, expr = false })
vim.keymap.set('i', 'jk', '<ESC>', { noremap = true, silent = true, expr = false })
vim.keymap.set('i', 'kj', '<ESC>', { noremap = true, silent = true, expr = false })
vim.keymap.set('i', 'kk', '<ESC>', { noremap = true, silent = true, expr = false })

vim.keymap.set('n', 'q:', '<Nop>', { noremap = true, silent = true })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true})
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true})
