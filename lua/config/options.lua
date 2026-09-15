vim.o.number = true
vim.o.relativenumber = true

vim.o.mouse = 'a'
vim.o.showmode = false -- already in the statusline

-- Scheduled after UiEnter: setting it eagerly costs startup time.
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.o.breakindent = true
vim.o.undofile = true

-- Case-insensitive search unless the pattern has \C or a capital letter.
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.o.inccommand = 'split' -- live preview of :substitute
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true -- prompt to save instead of failing on :q

vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  virtual_text = true,
  virtual_lines = false,
  jump = { float = true }, -- show the float when jumping with [d / ]d
}
