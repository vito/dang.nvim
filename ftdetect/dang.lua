vim.filetype.add({
  extension = {
    dang = "dang",
  },
  pattern = {
    [".*"] = {
      priority = -math.huge,
      function(_, bufnr)
        local line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or ""
        if line:match("^#!.*%bdang%b") then
          return "dang"
        end
      end,
    },
  },
})
