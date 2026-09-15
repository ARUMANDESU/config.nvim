return {
  {
    'https://gitlab.com/motaz-shokry/gruvbox.nvim',
    priority = 1000,
    config = function()
      require('gruvbox').setup {
        variant = 'medium', -- auto, hard, medium, soft, light
        dark_variant = 'hard', -- hard, medium, soft
      }
      vim.cmd.colorscheme 'gruvbox'
    end,
  },
}
