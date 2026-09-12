vim.keymap.set('n', '<leader>x', '<CMD>source %<CR>')

vim.keymap.set('n', '<leader>sa', 'ggVG', { desc = '[S]elect [A]ll' })
vim.keymap.set('n', '<leader>bq', '<CMD>q<CR>')
vim.keymap.set('n', '<leader>bw', '<CMD>w<CR>')

vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected lines up' })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected lines down' })
