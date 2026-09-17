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

-- Flash labels default to Substitute, which gruvbox paints dark orange on dark
-- background. Use gruvbox's bright yellow/aqua instead.
local function set_flash_highlights()
  vim.api.nvim_set_hl(0, 'FlashLabel', { fg = '#1b1b1b', bg = '#fabd2f', bold = true })
  vim.api.nvim_set_hl(0, 'FlashCurrent', { fg = '#1b1b1b', bg = '#8ec07c', bold = true })
  vim.api.nvim_set_hl(0, 'FlashMatch', { fg = '#83a598', bg = '#3c3836' })
  vim.api.nvim_set_hl(0, 'FlashBackdrop', { fg = '#665c54' })
end

set_flash_highlights()
vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('flash-highlights', { clear = true }),
  callback = set_flash_highlights,
})
