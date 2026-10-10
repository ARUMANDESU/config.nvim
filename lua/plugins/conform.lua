return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function() require('conform').format { async = true, lsp_format = 'fallback' } end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- No format-on-save for languages without a standardized style.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then return nil end
        return { timeout_ms = 500, lsp_format = 'fallback' }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        go = { 'goimports' },
        templ = { 'templ' },
        sql = { 'sqruff' },
        dockerfile = { 'dockerfmt' },
        makefile = { 'mbake' },
        c = { 'clang-format' },
      },
      formatters = {
        ['clang-format'] = {
          -- prepend_args allows adding flags before user arguments
          prepend_args = {
            -- This string mimics the YAML syntax inside a single line
            '-style={BasedOnStyle: LLVM, TabWidth: 4, IndentWidth: 4}',
            -- This tells clang-format to use this style if no local .clang-format is found
            '-fallback-style=LLVM',
          },
        },
      },
    },
  },
}
