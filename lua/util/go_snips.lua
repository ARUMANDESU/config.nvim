-- Go snippet helpers: build `return` values that match the enclosing function's
-- result list, using treesitter.
-- Derived from https://github.com/ray-x/go.nvim/blob/master/lua/go/snips.lua
-- (originally https://github.com/arsham/shark).

local ls = require 'luasnip'
local fmt = require('luasnip.extras.fmt').fmt

local M = {}

---Node for an `error` return: wrap it, turn it into a gRPC error, or pass it through.
function M.go_err_snippet(args, _, _, spec)
  local err_name = args[1][1]
  local index = spec and spec.index or nil
  local msg = spec and spec[1] or ''
  if spec and spec[2] then err_name = err_name .. spec[2] end

  return ls.sn(index, {
    ls.c(1, {
      ls.sn(nil, fmt('fmt.Errorf("{}: %w", {})', { ls.i(1, msg), ls.t(err_name) })),
      ls.sn(
        nil,
        fmt('internal.GrpcError({},\n\t\tcodes.{}, "{}", "{}", {})', {
          ls.t(err_name),
          ls.i(1, 'Internal'),
          ls.i(2, 'Description'),
          ls.i(3, 'Field'),
          ls.i(4, 'fields'),
        })
      ),
      ls.t(err_name),
    }),
  })
end

---Turns a result type (as written in source) into a sensible zero-value node.
local function transform(text, info)
  local string_sn = function(template, default)
    info.index = info.index + 1
    return ls.sn(info.index, fmt(template, ls.i(1, default)))
  end
  local new_sn = function(default) return string_sn('{}', default) end

  -- Collapse compound types down to a keyword we can switch on.
  if text:find [[^[^\[]*string$]] then
    text = 'string'
  elseif text:find '^[^%[]*map%[[^%]]+' then
    text = 'map'
  elseif text:find '%[%]' then
    text = 'slice'
  elseif text:find [[ ?chan +[%a%d]+]] then
    return ls.t 'nil'
  end

  -- Drop the parameter name when the result is named, e.g. `n int`.
  local type = text:match [[^[%a%d]+ ([%a%d]+)$]]
  if type then text = type end

  if text == 'int' or text == 'int64' or text == 'int32' then
    return new_sn '0'
  elseif text == 'float32' or text == 'float64' then
    return new_sn '0'
  elseif text == 'error' then
    if not info then return ls.t 'err' end
    info.index = info.index + 1
    return M.go_err_snippet({ { info.err_name } }, nil, nil, { index = info.index })
  elseif text == 'bool' then
    info.index = info.index + 1
    return ls.c(info.index, { ls.i(1, 'false'), ls.i(2, 'true') })
  elseif text == 'string' then
    return string_sn('"{}"', '')
  elseif text == 'map' or text == 'slice' then
    return ls.t 'nil'
  elseif string.find(text, '*', 1, true) then
    return new_sn 'nil'
  end

  text = text:match '[^ ]+$'
  if text == 'context.Context' then
    text = 'context.Background()'
  else
    text = text .. '{}' -- concrete type
  end

  return ls.t(text)
end

local get_node_text = vim.treesitter.get_node_text

local handlers = {
  parameter_list = function(node, info)
    local result = {}
    local count = node:named_child_count()
    for idx = 0, count - 1 do
      table.insert(result, transform(get_node_text(node:named_child(idx), 0), info))
      if idx ~= count - 1 then table.insert(result, ls.t { ', ' }) end
    end
    return result
  end,

  type_identifier = function(node, info) return { transform(get_node_text(node, 0), info) } end,
}

local query_is_set = false

local function set_query()
  if query_is_set then return end
  query_is_set = true
  vim.treesitter.query.set(
    'go',
    'LuaSnip_Result',
    [[
      [
        (method_declaration result: (_) @id)
        (function_declaration result: (_) @id)
        (func_literal result: (_) @id)
      ]
  ]]
  )
end

local function return_value_nodes(info)
  set_query()

  local function_node = vim.treesitter.get_node { bufnr = 0 }
  while function_node do
    if function_node:type() == 'function_declaration' or function_node:type() == 'method_declaration' or function_node:type() == 'func_literal' then break end
    function_node = function_node:parent()
  end
  if not function_node then return end

  local query = vim.treesitter.query.get('go', 'LuaSnip_Result')
  for _, node in query:iter_captures(function_node, 0) do
    if handlers[node:type()] then return handlers[node:type()](node, info) end
  end
  return ls.t { '' }
end

---@return boolean true when the cursor sits inside a func, method or closure body
function M.in_function()
  local expr = vim.treesitter.get_node { bufnr = 0 }
  while expr do
    local t = expr:type()
    if t == 'function_declaration' or t == 'method_declaration' or t == 'func_literal' then return true end
    expr = expr:parent()
  end
  return false
end

function M.in_test_file() return vim.endswith(vim.fn.expand '%:p', '_test.go') end

function M.in_test_function() return M.in_test_file() and M.in_function() end

---Dynamic node returning the zero values for the enclosing function's results.
---@param args table luasnip node args; args[1][1] is the error variable name
function M.make_return_nodes(args) return ls.sn(nil, return_value_nodes { index = 0, err_name = args[1][1] }) end

return M
