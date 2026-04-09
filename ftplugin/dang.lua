-- Tree-sitter features
local has_parser = pcall(vim.treesitter.language.inspect, 'dang')
if has_parser then
  pcall(vim.treesitter.start, 0, 'dang')
end

local has_nvim_treesitter = pcall(require, 'nvim-treesitter')
if has_parser and has_nvim_treesitter then
  vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

-- Buffer options
vim.bo.commentstring = '# %s'
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true
