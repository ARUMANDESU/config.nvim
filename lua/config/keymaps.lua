local map = vim.keymap.set

-- List navigation with wrap-around
local function list_nav(opts)
  local size = opts.loc and vim.fn.getloclist(0, { size = 0 }).size or vim.fn.getqflist({ size = 0 }).size

  if size == 0 then
    vim.notify(opts.loc and 'No location list items' or 'Quickfix list is empty', vim.log.levels.WARN)
    return
  end

  local ok, err = pcall(vim.cmd[opts.step])
  if ok then return end

  if err:match 'E553' then -- "No more items": wrap around
    vim.cmd[opts.wrap]()
    vim.notify(opts.msg, vim.log.levels.INFO)
  else
    vim.notify(err, vim.log.levels.ERROR) -- e.g. E37 (unsaved changes)
  end
end

map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

map('n', '<leader>sx', '<CMD>source %<CR>', { desc = '[S]ource current file' })
map('n', '<leader>sa', 'ggVG', { desc = '[S]elect [A]ll' })

map('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true, desc = 'Make file executable' })

-- Move selected lines.
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected lines up' })
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected lines down' })

-- Window navigation. Ctrl+w chords stay native.
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Delete/change go to the black hole so they don't clobber the yank register.
map({ 'n', 'v' }, 'c', '"_c')
map({ 'n', 'v' }, 'C', '"_C')
map({ 'n', 'v' }, 'x', '"_x')
map('v', 'p', '"_dP', { desc = 'Paste over selection, keeping the yank' })

-- Append empty line before/after cursor.
map('n', '<leader>o', 'o<Esc>', { desc = 'Append a blank line below' })
map('n', '<leader>O', 'O<Esc>', { desc = 'Append a blank line above' })

-- Indent in visual mode preserving select.
map('v', '<', '<gv', { desc = 'Decrease indentation' })
map('v', '>', '>gv', { desc = 'Increase indentation' })

-- Quickfix List

map('n', '<leader>qq', function()
  if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
    vim.cmd.cclose()
  else
    vim.cmd.copen()
  end
end, { desc = '[Q]uickfix Window Toggle' })
map(
  'n',
  '<leader>qn',
  function() list_nav { step = 'cnext', wrap = 'cfirst', msg = 'Quickfix: wrapped to first item' } end,
  { desc = '[Q]uickfix [N]ext Item (wraps)' }
)
map(
  'n',
  '<leader>qp',
  function() list_nav { step = 'cprevious', wrap = 'clast', msg = 'Quickfix: wrapped to last item' } end,
  { desc = '[Q]uickfix [P]revious Item (wraps)' }
)
map('n', '<leader>qf', '<cmd>cfirst<CR>', { desc = '[Q]uickfix [F]irst Item' })
map('n', '<leader>ql', '<cmd>clast<CR>', { desc = '[Q]uickfix [L]ast Item' })

-- Quickfix List Diagnostic
map('n', '<leader>qd', vim.diagnostic.setqflist, { desc = '[Q]uickfix [D]iagnostics' })

-- Location List
map('n', '<leader>ll', function()
  if vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 then
    vim.cmd.lclose()
  else
    local ok = pcall(vim.cmd.lopen)
    if not ok then vim.notify('No location list', vim.log.levels.WARN) end
  end
end, { desc = '[L]ocation [L]ist Window Toggle' })
map(
  'n',
  '<leader>ln',
  function() list_nav { loc = true, step = 'lnext', wrap = 'lfirst', msg = 'Location list: wrapped to first item' } end,
  { desc = '[L]ocation List [N]ext (wraps)' }
)
map(
  'n',
  '<leader>lp',
  function() list_nav { loc = true, step = 'lprevious', wrap = 'llast', msg = 'Location list: wrapped to last item' } end,
  { desc = '[L]ocation List [P]revious (wraps)' }
)
map('n', '<leader>lf', '<cmd>lfirst<CR>', { desc = '[L]ocation List [F]irst Item' })
map('n', '<leader>lL', '<cmd>llast<CR>', { desc = '[L]ocation List [L]ast Item' })

-- Location List Diagnostics
map('n', '<leader>ld', vim.diagnostic.setloclist, { desc = '[L]ocation List [D]iagnostics' })
