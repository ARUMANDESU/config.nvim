local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local fmt = require('luasnip.extras.fmt').fmt
local snips = require 'custom.go.snips'

local in_test_fn = {
  show_condition = snips.in_test_function,
  condition = snips.in_test_function,
}

local in_test_file = {
  show_condition = snips.in_test_file_fn,
  condition = snips.in_test_file_fn,
}

local in_fn = {
  show_condition = snips.in_function,
  condition = snips.in_function,
}

local not_in_fn = {
  show_condition = snips.in_func,
  condition = snips.in_func,
}

local snippets = {
  s(
    { trig = 'ife', name = 'If error, choose me!', dscr = 'If error, return wrapped with dynamic node' },
    fmt('if {} != nil {{\n\treturn {}\n}}\n{}', {
      ls.i(1, 'err'),
      ls.d(2, snips.make_return_nodes, { 1 }, { user_args = { { 'a1', 'a2' } } }),
      ls.i(0),
    }),
    in_fn
  ),
}

ls.add_snippets('go', snippets)
