-- Tree-sitter features
vim.treesitter.start()
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

-- Buffer options
vim.bo.commentstring = '# %s'
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.expandtab = false
