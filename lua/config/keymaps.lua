local map = vim.keymap.set

map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

map('n', '<leader>sx', '<CMD>source %<CR>', { desc = '[S]ource current file' })
map('n', '<leader>sa', 'ggVG', { desc = '[S]elect [A]ll' })

map('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true, desc = 'Make file executable' })

map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected lines up' })
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected lines down' })

-- Window navigation. Ctrl+w chords stay native; Ctrl is aerospace's plane, so no Ctrl+Shift here.
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Delete/change go to the black hole so they don't clobber the yank register.
map({ 'n', 'v' }, 'c', '"_c')
map({ 'n', 'v' }, 'C', '"_C')
map({ 'n', 'v' }, 'x', '"_x')
map('v', 'p', '"_dP', { desc = 'Paste over selection, keeping the yank' })
