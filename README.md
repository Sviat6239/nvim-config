# Neovim Monolithic Config

A single-file Neovim configuration (`init.lua`) with:
- Smart auto-pair insertion  
- Syntax highlighting for multiple languages  
- No external dependencies  

## Features

- Auto-inserts matching pairs for `{`, `[`, `(`, `"`, `'`, `<`, and `` ` ``  
- Nested pair expansion — pressing the same key again adds another full pair  
- Built-in syntax highlighting for:
  - JavaScript / TypeScript  
  - D / C / C++  
  - Python  
  - Lua  
  - FASM / NASM  
- Fully monolithic — no separate plugin files or mappings  

## Usage

Just place the provided `init.lua` into your Neovim config directory:

**Linux / macOS:**
```bash
~/.config/nvim/init.lua
