-- Tree-sitter features
vim.treesitter.start()
vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo[0][0].foldmethod = 'expr'
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

-- Buffer options
vim.bo.commentstring = '# %s'
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.expandtab = false
