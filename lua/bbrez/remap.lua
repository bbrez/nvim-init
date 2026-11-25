vim.keymap.set('n', '<leader>wh', '<cmd>split<cr>', {
  desc = 'Horizontal Split',
})

vim.keymap.set('n', '<leader>wv', '<cmd>vsplit<cr>', {
  desc = 'Vertical Split',
})

vim.keymap.set('n', ']b', '<cmd>bnext<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '[b', '<cmd>bprev<cr>', { desc = 'Previous buffer' })

vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('i', 'kj', '<Esc>')
vim.keymap.set('i', 'kk', '<Esc>')

vim.keymap.set('n', 'q:', '<Nop>')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('t', '<Esc>', '<C-\\><C-N>')

vim.keymap.set('n', '<leader>tn', '<cmd>terminal<cr>', { desc = 'New terminal' })
vim.keymap.set('n', '<leader>ts', '<cmd>split | terminal<cr>', { desc = 'Terminal split' })
vim.keymap.set('n', '<leader>tv', '<cmd>vsplit | terminal<cr>', { desc = 'Terminal vsplit' })

vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = 'Next diagnostic' })

vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = 'Previous diagnostic' })
