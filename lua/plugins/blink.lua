return {
  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          -- jsregexp gives snippets regex transforms; skip where make isn't available.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then return end
          return 'make install_jsregexp'
        end)(),
        config = function()
          local ls = require 'luasnip'
          ls.config.setup { enable_autosnippets = true }

          require 'snippets'

          vim.keymap.set('i', '<C-E>', function() ls.expand() end, { silent = true, desc = 'Expand snippet' })
          vim.keymap.set({ 'i', 's' }, '<C-L>', function() ls.jump(1) end, { silent = true, desc = 'Next snippet node' })
          vim.keymap.set({ 'i', 's' }, '<C-H>', function() ls.jump(-1) end, { silent = true, desc = 'Previous snippet node' })
          vim.keymap.set({ 'i', 's' }, '<C-N>', function()
            if ls.choice_active() then ls.change_choice(1) end
          end, { silent = true, desc = 'Next snippet choice' })
          vim.keymap.set({ 'i', 's' }, '<C-P>', '<CMD>lua require("luasnip.extras.select_choice")()<CR>', { silent = true, desc = 'Pick snippet choice' })
        end,
      },
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      -- 'default' = built-in-completion-like mappings; see :help ins-completion.
      keymap = { preset = 'default' },
      appearance = { nerd_font_variant = 'mono' },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets' },
      },
      snippets = { preset = 'luasnip' },
      fuzzy = { implementation = 'lua' }, -- 'prefer_rust_with_warning' downloads a prebuilt binary
      signature = { enabled = true },
    },
  },
}
