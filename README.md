<h1 align='center'>put_at_end.nvim</h1>
Small Neovim plugin that provides keymaps for putting certain characters (or strings) at the end of the current line (but before the comment if the line has one) without moving your cursor.

Useful for languages that require semicolons at the end of the line.

## Usage

```lua
  local m = require("put_at_end")
  vim.keymap.set("n", "<C-;>", m.put_semicolon)
  -- This keymap will put a semicolon at the end of the current line

  vim.keymap.set("n", "<C-.>", m.put_period) --This a period
  vim.keymap.set("n", "<C-,>", m.put_comma) --This a commna
  vim.keymap.set("n", "<C-/>", m.put_questionmark) --This a question mark
  vim.keymap.set("n", "<C-A>", function() m.put("STRING") end) --This 'STRING'
```

## Installation and Example Configuration

- With [lazy](https://github.com/folke/lazy.nvim)

```lua
{
  "rareitems/put_at_end.nvim",
  keys = { -- Basic lazy loading
    -- Plugin doesn't set any keymaps you have to set your own
    {
      "<C-;>",
      function()
        require("put_at_end").put_semicolon()
      end,
      desc = "Put a semicolon at the end of the line",
    },
    {
      "<C-.>",
      function()
        require("put_at_end").put_period()
      end,
      desc = "Put a period at the end of the line",
    },
    {
      "<C-,>",
      function()
        require("put_at_end").put_comma()
      end,
      desc = "Put a comma at the end of the line",
    },
  },
}
```

- With [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use { 'rareitems/put_at_end.nvim' }
```
