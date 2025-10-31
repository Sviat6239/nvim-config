# Neovim Monolithic Config

A single-file Neovim configuration (`init.lua`) with:  
- Smart auto-pair insertion  
- Rainbow brackets with 8-color cycling  
- Highlighted current line  
- Syntax highlighting for multiple languages via Treesitter  
- LSP support for several languages  
- No external plugin dependencies  

## Features

- **Auto-inserts matching pairs** for `{`, `[`, `(`, `"`, `'`, `<`, and `` ` ``  
- **Nested pair expansion** — pressing the same key again adds another full pair  
- **Rainbow brackets** — each opening bracket `[ { (` gets a unique color cycling through 8 colors  
- **Current line highlighting** with bright, easy-on-the-eyes color  
- **Syntax highlighting** for:
  - JavaScript / TypeScript  
  - D / C / C++  
  - Python  
  - Lua  
  - FASM / NASM  
  - HTML / CSS / Bash  
- **LSP support** for real-time error checking and autocompletion:
  - Python (`pyright`)  
  - C / C++ (`clangd`)  
  - JavaScript / TypeScript (`tsserver`)  
  - HTML (`html`)  
  - CSS (`cssls`)  
  - Bash (`bashls`)  
  - Lua (`lua_ls`)  
  - D (`d_language_server`, if installed)  
- Fully monolithic — no separate plugin files or key mappings  

## Usage

Place the `init.lua` into your Neovim config directory:

**Linux / macOS:**
```bash
~/.config/nvim/init.lua
```
**Windows:**
```bash
%USERPROFILE%\AppData\Local\nvim\init.lua
```
Then launch Neovim — everything will work out of the box.
