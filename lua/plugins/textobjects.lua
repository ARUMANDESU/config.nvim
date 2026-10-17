-- got from https://github.com/vimichael/my-nvim-config
-- `main` branch: no `keymaps` tables in setup; mappings are defined explicitly below.
return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  branch = 'main',
  dependencies = { 'nvim-treesitter' },
  config = function()
    require('nvim-treesitter-textobjects').setup {
      move = { set_jumps = true },
      select = {
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        selection_modes = {
          ['@parameter.outer'] = 'v', -- charwise
          ['@function.outer'] = 'V', -- linewise
          ['@class.outer'] = '<c-v>', -- blockwise
        },
        -- Extend textobjects with surrounding whitespace, like the built-in `ap`.
        include_surrounding_whitespace = true,
      },
    }

    local select = require 'nvim-treesitter-textobjects.select'
    local move = require 'nvim-treesitter-textobjects.move'
    local map = vim.keymap.set

    -- Select: af/if function, ac/ic class, as language scope
    for lhs, obj in pairs {
      af = { '@function.outer', 'textobjects', 'Select outer function' },
      ['if'] = { '@function.inner', 'textobjects', 'Select inner function' },
      ac = { '@class.outer', 'textobjects', 'Select outer part of a class region' },
      ic = { '@class.inner', 'textobjects', 'Select inner part of a class region' },
      as = { '@local.scope', 'locals', 'Select language scope' },
    } do
      map({ 'x', 'o' }, lhs, function() select.select_textobject(obj[1], obj[2]) end, { desc = obj[3] })
    end

    -- Move: `]` = next, `[` = previous; lowercase = start, uppercase = end.
    -- Classes use ]] / [[ (start) and ][ / [] (end); ]c / [c belong to gitsigns.
    local moves = {
      [']f'] = { move.goto_next_start, '@function.outer', 'Next function start' },
      [']F'] = { move.goto_next_end, '@function.outer', 'Next function end' },
      ['[f'] = { move.goto_previous_start, '@function.outer', 'Previous function start' },
      ['[F'] = { move.goto_previous_end, '@function.outer', 'Previous function end' },
      [']]'] = { move.goto_next_start, '@class.outer', 'Next class start' },
      ['[['] = { move.goto_previous_start, '@class.outer', 'Previous class start' },
      ['[]'] = { move.goto_previous_end, '@class.outer', 'Previous class end' },
      [']['] = { move.goto_next_end, '@class.outer', 'Next class end' },
    }
    for lhs, m in pairs(moves) do
      map({ 'n', 'x', 'o' }, lhs, function() m[1](m[2], 'textobjects') end, { desc = m[3] })
    end
  end,
}
