local M = {}

function M.setup(opts)
  opts = opts or {}
  local enable_lsp = opts.lsp ~= false

  -- Register Tree-sitter parser for :TSInstall/:TSUpdate
  vim.api.nvim_create_autocmd('User', {
    pattern = 'TSUpdate',
    callback = function()
      require('nvim-treesitter.parsers').dang = {
        install_info = {
          url = 'https://github.com/vito/dang',
          location = 'treesitter',
          files = { 'src/parser.c' },
          branch = 'main',
        },
      }
    end,
  })

  -- Set up LSP
  if enable_lsp then
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dang",
      callback = function(ev)
        vim.lsp.start({
          name = "dang",
          cmd = { "dang", "--lsp" },
          root_dir = vim.fs.root(ev.buf, { "dagger.json", ".git" }),
        })
      end,
    })
  end
end

return M
