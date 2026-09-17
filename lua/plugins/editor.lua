return {
  { 'NMAC427/guess-indent.nvim', opts = {} },
  { 'nvim-tree/nvim-web-devicons' },
  { 'windwp/nvim-autopairs', event = 'InsertEnter', opts = {} },
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} },
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = { modes = { char = { enabled = false } } },
    keys = {
      { 'f', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash' },
      { 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote Flash' },
      { 'R', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
      { '<c-s>', mode = { 'c' }, function() require('flash').toggle() end, desc = 'Toggle Flash Search' },
      {
        'zu',
        mode = { 'n', 'o', 'x' },
        function()
          require('flash').treesitter {
            jump = { pos = 'end' },
            label = { before = true, after = true, style = 'overlay' },
          }
        end,
        desc = 'Flash Treesitter',
      },
      {
        'zU',
        mode = { 'n', 'o', 'x' },
        function()
          require('flash').treesitter {
            jump = { pos = 'start' },
            label = { before = true, after = true, style = 'overlay' },
          }
        end,
        desc = 'Flash Treesitter',
      },
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },

  { -- Shows pending keybinds
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = { mappings = vim.g.have_nerd_font },
      spec = {
        { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk | [H]arpoon', mode = { 'n', 'v' } },
        { '<leader>b', group = '[B]uffer' },
      },
    },
  },

  {
    's1n7ax/nvim-window-picker',
    name = 'window-picker',
    event = 'VeryLazy',
    version = '2.*',
    opts = {
      hint = 'floating-big-letter',
      selection_chars = 'TNSERIAOPLFUWYQ:', -- colemak order
      picker_config = {
        handle_mouse_click = false,
        floating_big_letter = { font = 'ansi-shadow' },
      },
      show_prompt = true,
      prompt_message = 'Pick window: ',
      filter_rules = {
        autoselect_one = true,
        include_current_win = false,
        include_unfocusable_windows = false,
        bo = {
          filetype = { 'NvimTree', 'neo-tree', 'notify', 'snacks_notif' },
          buftype = { 'terminal' },
        },
      },
      highlights = {
        enabled = true,
        statusline = {
          focused = { fg = '#ededed', bg = '#e35e4f', bold = true },
          unfocused = { fg = '#ededed', bg = '#44cc41', bold = true },
        },
        winbar = {
          focused = { fg = '#ededed', bg = '#e35e4f', bold = true },
          unfocused = { fg = '#ededed', bg = '#44cc41', bold = true },
        },
      },
    },
  },
}
