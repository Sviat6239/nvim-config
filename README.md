# AutoPairs+ Syntax Highlighting Plugin

A minimal Neovim plugin written in Lua that provides:
- Auto-closing of brackets, braces, parentheses, quotes, and backticks.
- Nested pair insertion (like in modern IDEs).
- Syntax highlighting for multiple languages (JS, TS, D, C, Python, Lua, FASM, NASM).

## Features

- Automatically inserts the matching closing symbol for `{`, `[`, `(`, `"`, `'`, `<`, and `` ` ``.
- Supports multiple levels of nested pairs (pressing the key again adds another full pair).
- Includes syntax highlighting configuration for:
  - JavaScript / TypeScript  
  - Dlang  
  - C / C++  
  - Python  
  - Lua  
  - FASM / NASM assembly

## Installation

Use your favorite plugin manager.

### Example (with `lazy.nvim`)
```lua
{
  "user/auto-pairs-syntax",
  config = function()
    require("auto_pairs_syntax").setup()
  end
}
