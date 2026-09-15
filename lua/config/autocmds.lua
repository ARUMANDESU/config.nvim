vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Neo-tree's green accents, reapplied whenever a colorscheme loads.
local function set_neotree_highlights()
  vim.api.nvim_set_hl(0, 'NeoTreeDirectoryIcon', { fg = '#a7c080' })
  vim.api.nvim_set_hl(0, 'NeoTreeDirectoryName', { fg = '#a7c080' })
  vim.api.nvim_set_hl(0, 'NeoTreeRootName', { fg = '#a7c080', bold = true })
end

set_neotree_highlights()
vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('neotree-highlights', { clear = true }),
  callback = set_neotree_highlights,
})
