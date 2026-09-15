local ls = require 'luasnip'
local fmt = require('luasnip.extras.fmt').fmt
local go = require 'util.go_snips'

local in_fn = { condition = go.in_function, show_condition = go.in_function }

ls.add_snippets('go', {
  ls.s(
    { trig = 'ife', name = 'If error', dscr = 'If err != nil, return the zero values of the enclosing function' },
    fmt('if {} != nil {{\n\treturn {}\n}}\n{}', {
      ls.i(1, 'err'),
      ls.d(2, go.make_return_nodes, { 1 }),
      ls.i(0),
    }),
    in_fn
  ),
})
