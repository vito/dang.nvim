local function repo_root()
  local source = debug.getinfo(1, 'S').source:sub(2)
  return vim.fn.fnamemodify(source, ':p:h:h')
end

local function prepend_rtp(path)
  if path and path ~= '' and vim.fn.isdirectory(path) == 1 then
    vim.opt.runtimepath:prepend(path)
    return true
  end
  return false
end

local root = repo_root()
prepend_rtp(root)

local nvim_treesitter_rtp = os.getenv('NVIM_TREESITTER_RTP')
if not nvim_treesitter_rtp or nvim_treesitter_rtp == '' then
  local matches = vim.fn.globpath(vim.o.packpath, 'pack/*/opt/nvim-treesitter', false, true)
  nvim_treesitter_rtp = matches[1]
end

assert(prepend_rtp(nvim_treesitter_rtp), 'nvim-treesitter not found; set NVIM_TREESITTER_RTP')
assert(pcall(vim.treesitter.language.inspect, 'dang'), 'dang parser not found; install it first')

local indent = require('nvim-treesitter.indent')

local function split_lines(source)
  source = source:gsub('\r\n', '\n')
  source = source:gsub('^\n', '')
  source = source:gsub('\n$', '')
  return vim.split(source, '\n', { plain = true })
end

local function open_buffer(source)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_current_buf(buf)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, split_lines(source))
  vim.bo[buf].filetype = 'dang'
  vim.bo[buf].tabstop = 2
  vim.bo[buf].shiftwidth = 2
  vim.bo[buf].softtabstop = 2
  vim.bo[buf].expandtab = true
  vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  vim.treesitter.start(buf, 'dang')
  return buf
end

local function collect_indents(buf)
  vim.api.nvim_set_current_buf(buf)
  local actual = {}
  for lnum = 1, vim.api.nvim_buf_line_count(buf) do
    actual[#actual + 1] = indent.get_indent(lnum)
  end
  return actual
end

local function format_list(values)
  return '[' .. table.concat(values, ', ') .. ']'
end

local function assert_indents(case)
  local buf = open_buffer(case.source)
  local actual = collect_indents(buf)
  vim.api.nvim_buf_delete(buf, { force = true })

  assert(
    #actual == #case.expected,
    string.format('%s: expected %d lines, got %d', case.name, #case.expected, #actual)
  )

  for i, expected in ipairs(case.expected) do
    local got = actual[i]
    assert(
      got == expected,
      string.format(
        '%s: line %d expected indent %d, got %d\nexpected: %s\nactual:   %s',
        case.name,
        i,
        expected,
        got,
        format_list(case.expected),
        format_list(actual)
      )
    )
  end
end

local cases = {
  {
    name = 'multiline declarations and bracketed literals',
    source = [[
let foo(
name: String!
): String! {
bar
}

foo(
1,
2
)

[
1,
2
]

{{
foo: 1
}}
]],
    expected = { 0, 2, 0, 2, 0, 0, 0, 2, 2, 0, 0, 0, 2, 2, 0, 0, 0, 2, 0 },
  },
  {
    name = 'nested blocks accumulate indentation',
    source = [[
let outer(): String! {
ifTrue {
foo(
[
{{
foo: 1
}}
]
)
}
}
]],
    expected = { 0, 2, 4, 6, 8, 10, 8, 6, 4, 2, 0 },
  },
  {
    name = 'unfinished opening delimiters indent the next line',
    source = [[
let foo(): String! {

foo(

[

{{
]],
    expected = { 0, 2, 0, 2, 0, 2, 0 },
  },
  {
    name = 'closing an inner construct returns to the outer indent level',
    source = [[
let outer(): String! {
foo(
1
)

bar
}
]],
    expected = { 0, 2, 4, 2, 2, 2, 0 },
  },
  {
    name = 'parenthesized expressions indent like calls',
    source = [[
let x = (
foo
)
]],
    expected = { 0, 2, 0 },
  },
}

for _, case in ipairs(cases) do
  assert_indents(case)
end

print(string.format('ok - %d indent cases', #cases))
vim.cmd('qa!')
