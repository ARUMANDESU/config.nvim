require 'custom.keymaps'

local function set_neotree_highlights()
  vim.api.nvim_set_hl(0, 'NeoTreeDirectoryIcon', { fg = '#a7c080' })
  vim.api.nvim_set_hl(0, 'NeoTreeDirectoryName', { fg = '#a7c080' })
  vim.api.nvim_set_hl(0, 'NeoTreeRootName', { fg = '#a7c080', bold = true })
end

set_neotree_highlights()
vim.api.nvim_create_autocmd('ColorScheme', { callback = set_neotree_highlights })
