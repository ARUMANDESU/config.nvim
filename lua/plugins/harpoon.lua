return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()

      local map = vim.keymap.set
      map('n', '<leader>a', function() harpoon:list():add() end, { desc = '[A]ppend to harpoon list' })
      map('n', '<C-s>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon quick menu' })

      -- Colemak home row: n e i o
      for idx, key in ipairs { '<M-n>', '<M-e>', '<M-i>', '<M-o>' } do
        map('n', key, function() harpoon:list():select(idx) end, { desc = 'Harpoon file ' .. idx })
      end
      for idx, key in ipairs { '<M-S-n>', '<M-S-e>', '<M-S-i>', '<M-S-o>' } do
        map('n', key, function() harpoon:list():replace_at(idx) end, { desc = 'Harpoon replace slot ' .. idx })
      end
    end,
  },
}
