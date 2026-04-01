local M = {}

function M.setup(opts)
  opts = opts or {}
  local enable_lsp = opts.lsp ~= false

  -- Register Tree-sitter parser
  local ok, parsers = pcall(require, "nvim-treesitter.parsers")
  if ok then
    parsers.dang = {
      install_info = {
        url = "https://github.com/vito/dang",
        location = "treesitter",
        files = { "src/parser.c" },
        branch = "main",
      },
    }
  end

  -- Set up basic filetype options
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "dang",
    callback = function()
      vim.bo.commentstring = "# %s"
      vim.bo.tabstop = 2
      vim.bo.shiftwidth = 2
      vim.bo.expandtab = false
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
