local ls = require 'luasnip'

vim.keymap.set({ 'i' }, '<C-E>', function() ls.expand() end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<C-L>', function() ls.jump(1) end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<C-H>', function() ls.jump(-1) end, { silent = true })

-- Choice
vim.keymap.set({ 'i', 's' }, '<C-N>', function()
  if ls.choice_active() then ls.change_choice(1) end
end, { silent = true, desc = 'Next snippet choice' })
vim.keymap.set({ 'i', 's' }, '<C-P>', '<CMD>lua require("luasnip.extras.select_choice")()<CR>')
