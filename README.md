<h1 align='center'>put_at_end.nvim</h1>
Small Neovim plugin that provides keymaps for putting certain characters (or strings) at the end of the current line (but before the comment if the line has one) without moving your cursor.

Useful for languages that require semicolons at the end of the line.

## Installation

- With [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use { 'rareitems/put_at_end.nvim' }
```

## Usage

```lua
  local m = require("put_at_end")
  local s = vim.keymap.set
  s("n", "<C-;>", m.put_semicolon)
  -- This keymap will put a semicolon at the end of the current line

  s("n", "<C-,>", m.put_period) --This a period
  s("n", "<C-.>", m.put_comma) --This a commna
  s("n", "<C-/>", m.put_questionmark) --This a question mark
  s("n", "<C-A>", function() m.put("STRING") end) --This 'STRING'
```
