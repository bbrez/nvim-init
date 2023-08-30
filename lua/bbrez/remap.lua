vim.g.mapleader = ' '

vim.keymap.set('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Tab>', ':bprev<CR>', { noremap = true, silent = true })

vim.keymap.set('i', 'jj', '<ESC>', { noremap = true, silent = true, expr = false })
vim.keymap.set('i', 'jk', '<ESC>', { noremap = true, silent = true, expr = false })
vim.keymap.set('i', 'kj', '<ESC>', { noremap = true, silent = true, expr = false })
vim.keymap.set('i', 'kk', '<ESC>', { noremap = true, silent = true, expr = false })

vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>ft', ':NvimTreeToggle<CR>', {
    noremap = true,
    silent = true,
    desc = 'Toggle File Tree'
})

vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', {
    noremap = true,
    silent = true,
    desc = 'Find Files'
})

vim.keymap.set('n', '<leader>fc', ':bdelete<CR>', {
    noremap = true,
    silent = true,
    desc = 'Close File'
})

vim.keymap.set('n', '<leader>fC', ':bdelete!<CR>', {
    noremap = true,
    silent = true,
    desc = 'Close File'
})

vim.keymap.set('n', '<leader>cf', ':LspZeroFormat<CR>', {
    noremap = true,
    silent = true,
    desc = 'Format File'
})

vim.keymap.set('n', '<leader>cc', '<cmd>lua vim.lsp.buf.code_action()<cr>', {
    noremap = true,
    silent = true,
    desc = 'Code Action'
})

vim.keymap.set('n', '<leader>md', ':MarkdownPreviewToggle<CR>', {
    noremap = true,
    silent = true,
    desc = 'Markdown Preview'
})

vim.keymap.set('n', '<leader>cd', ':TroubleToggle<CR>', {
    noremap = true,
    silent = true,
    desc = 'Code Diagnostics'
})

vim.keymap.set('n', '<leader>td', ':TodoTelescope<CR>', {
    noremap = true,
    silent = true,
    desc = 'Todo List'
})
