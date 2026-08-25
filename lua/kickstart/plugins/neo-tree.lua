-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = true,
        hide_by_name = {
          'node_modules',
        },
        hide_by_pattern = {
          --"*.meta",
          --"*/src/*/tsconfig.json",
        },
        always_show = {
          '.gitignored',
          'custom',
        },
        never_show = {
          '.DS_Store',
          --"thumbs.db"
        },
        never_show_by_pattern = {
          --".null-ls_*",
        },
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['Y'] = function(state)
            local node = state.tree:get_node()
            local path = node:get_id() -- absolute path of the node
            vim.fn.setreg('+', path, 'c') -- copy to + register (clipboard)
            vim.notify('Copied: ' .. path)
          end,
          ['gy'] = function(state) -- relative path (to cwd)
            local p = vim.fn.fnamemodify(state.tree:get_node():get_id(), ':.')
            vim.fn.setreg('+', p, 'c')
            vim.notify('Copied: ' .. p)
          end,
          ['gn'] = function(state) -- just the filename
            local p = vim.fn.fnamemodify(state.tree:get_node():get_id(), ':t')
            vim.fn.setreg('+', p, 'c')
            vim.notify('Copied: ' .. p)
          end,
        },
      },
    },
  },
}
