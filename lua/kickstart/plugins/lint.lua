return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        go = { 'golangcilint' },
      }

      local disabled_fts = {}

      -- Apply "quiet mode" (signs only) or "full mode" (signs + underline + virtual_text)
      -- to every linter namespace used by a given filetype.
      local function set_display(ft, quiet)
        local linters = lint.linters_by_ft[ft] or {}
        for _, linter_name in ipairs(linters) do
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

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          local ft = vim.bo.filetype
          if disabled_fts[ft] then return end
          if vim.bo.modifiable then lint.try_lint() end
        end,
      })

      vim.api.nvim_create_user_command('LintToggle', function()
        local ft = vim.bo.filetype
        disabled_fts[ft] = not disabled_fts[ft]

        if disabled_fts[ft] then
          set_display(ft, true) -- quiet: signs only, stop re-linting
          vim.notify('Linting quieted for ' .. ft .. ' (signs kept, text hidden)')
        else
          set_display(ft, false) -- full display restored
          lint.try_lint()
          vim.notify('Linting enabled for ' .. ft)
        end
      end, { desc = 'Toggle linting for current filetype' })

      vim.keymap.set('n', '<leader>tl', '<cmd>LintToggle<CR>', { desc = '[T]oggle [L]inting (filetype)' })
    end,
  },
}
