# Neovim Monolithic Config

A single-file Neovim configuration (`init.lua`) with:  
- Smart auto-pair insertion  
- Rainbow brackets with 8-color cycling  
- Highlighted current line  
- Syntax highlighting for multiple languages via Treesitter  
- LSP support for several languages  
- Autoformatting on save via LSP  
- TODO/FIXME/NOTE highlighting in comments  
- Mini-outline of current function/class in statusline  
- No external plugin dependencies  

## Features

- **Auto-inserts matching pairs** for `{`, `[`, `(`, `"`, `'`, `<`, and `` ` ``  
- **Nested pair expansion** — pressing the same key again adds another full pair  
- **Auto-deletes pairs** when Backspace is pressed between them  
- **Rainbow brackets** — each opening bracket `[ { (` gets a unique color cycling through 8 colors  
- **Current line highlighting** with bright, easy-on-the-eyes color  
- **Syntax highlighting** for:
  - JavaScript / TypeScript  
  - D / C / C++  
  - Python  
  - Lua  
  - FASM / NASM  
  - HTML / CSS / Bash  
  - Java / C#  
  - Go / Rust / PHP  
- **LSP support** for real-time error checking, autocompletion, and formatting:
  - Python (`pyright`)  
  - C / C++ (`clangd`)  
  - JavaScript / TypeScript (`tsserver`)  
  - HTML (`html`)  
  - CSS (`cssls`)  
  - Bash (`bashls`)  
  - Lua (`lua_ls`)  
  - D (`d_language_server`, if installed)  
  - Rust (`rust_analyzer`)  
  - Go (`gopls`)  
  - PHP (`intelephense`)  
  - C# (`omnisharp`)  
  - Java (`jdtls`)  
- **Autoformat on save** for all supported languages  
- **Highlight TODO/FIXME/NOTE** comments with bright colors  
- **Mini-outline** in statusline showing current function or class  
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
## Notes
- LSP servers must be installed on your system for their respective languages.
- Rainbow brackets and auto-pairs work automatically while typing.
- TODO/FIXME/NOTE comments are highlighted for easy tracking.
- The current function/class is displayed dynamically in the statusline.
- Column rulers visually indicate code length limits.
- Autoformatting ensures consistent code style on every save.
