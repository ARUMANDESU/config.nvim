return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        go = { 'golangcilint' },
      }

      lint.linters.markdownlint.args = {
        '--disable',
        'MD013',
        'MD007',
        '--', -- Required
      }

      local disabled_fts = {}

      -- Quiet mode keeps signs but hides underline/virtual text, per linter namespace.
      local function set_display(ft, quiet)
        for _, linter_name in ipairs(lint.linters_by_ft[ft] or {}) do
          local ok, ns = pcall(lint.get_namespace, linter_name)
          if ok and ns then
            vim.diagnostic.config({
              signs = true,
              underline = not quiet,
              virtual_text = not quiet,
            }, ns)
          end
        end
      end

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = vim.api.nvim_create_augroup('lint', { clear = true }),
        callback = function()
          if disabled_fts[vim.bo.filetype] then return end
          if vim.bo.modifiable then lint.try_lint() end
        end,
      })

      vim.api.nvim_create_user_command('LintToggle', function()
        local ft = vim.bo.filetype
        disabled_fts[ft] = not disabled_fts[ft]

        if disabled_fts[ft] then
          set_display(ft, true)
          vim.notify('Linting quieted for ' .. ft .. ' (signs kept, text hidden)')
        else
          set_display(ft, false)
          lint.try_lint()
          vim.notify('Linting enabled for ' .. ft)
        end
      end, { desc = 'Toggle linting for current filetype' })

      vim.keymap.set('n', '<leader>tl', '<cmd>LintToggle<CR>', { desc = '[T]oggle [L]inting (filetype)' })
    end,
  },
}
