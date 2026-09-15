-- Yank a node's path to the clipboard; `modifier` is a :help filename-modifiers
-- string, or nil for the node's own (absolute) path.
local function copy_path(modifier)
  return function(state)
    local path = state.tree:get_node():get_id()
    if modifier then path = vim.fn.fnamemodify(path, modifier) end
    vim.fn.setreg('+', path, 'c')
    vim.notify('Copied: ' .. path)
  end
end

return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    lazy = false,
    keys = {
      { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
      { '<C-N>', '<Cmd>Neotree toggle<CR>', desc = 'NeoTree toggle', silent = true },
    },
    opts = {
      filesystem = {
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = true,
          hide_by_name = { 'node_modules' },
          never_show = { '.DS_Store' },
        },
        window = {
          mappings = {
            ['\\'] = 'close_window',
            ['Y'] = copy_path(), -- absolute path
            ['gy'] = copy_path ':.', -- path relative to cwd
            ['gn'] = copy_path ':t', -- filename only
          },
        },
      },
    },
  },
}
