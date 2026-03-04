# dang.nvim

Neovim plugin for the [Dang](https://github.com/vito/dang) language,
providing Tree-sitter highlighting and LSP support.

## Requirements

- Neovim >= 0.10
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- `dang` binary in your `$PATH` (for LSP)

## Installation

### lazy.nvim

```lua
{
  "https://github.com/vito/dang.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("dang").setup()
  end,
}
```

### Manual

Clone into your Neovim packages directory and call `require("dang").setup()`.

## What it does

- Registers the `dang` filetype for `*.dang` files
- Installs the Tree-sitter grammar and queries (highlights, folds, indents, locals)
- Starts the Dang LSP (`dang --lsp`) automatically for `.dang` files

## Configuration

```lua
require("dang").setup({
  lsp = true, -- set to false to disable LSP
})
```
