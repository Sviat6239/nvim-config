-- ===============================
--  Smart Neovim config 
-- ===============================

-- Basic options
vim.o.number = true
vim.o.relativenumber = true
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.smartindent = true
vim.o.termguicolors = true
vim.o.cursorline = true
vim.o.mouse = "a"
vim.cmd("syntax on")

-- ===============================
--  Rainbow brackets colors
-- ===============================
local colors = {
  "#e06c75", "#d19a66", "#e5c07b", "#98c379",
  "#56b6c2", "#61afef", "#c678dd", "#be5046"
}

for i, color in ipairs(colors) do
  vim.cmd(string.format("highlight Rainbow%d guifg=%s", i, color))
end

-- Highlight current line brighter
vim.cmd("highlight CursorLine guibg=#2c2c2c ctermbg=238")

local brackets = {"(", "[", "{"}

-- Global function for rainbow brackets
_G.rainbow_brackets = function()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_clear_namespace(bufnr, -1, 0, -1)
  for i=0, vim.api.nvim_buf_line_count(bufnr)-1 do
    local line = vim.api.nvim_buf_get_lines(bufnr, i, i+1, false)[1]
    if line then
      local color_idx = 1
      for j=1,#line do
        local char = line:sub(j,j)
        for _, b in ipairs(brackets) do
          if char == b then
            local group = "Rainbow"..color_idx
            vim.api.nvim_buf_add_highlight(bufnr, -1, group, i, j-1, j)
            color_idx = color_idx % #colors + 1
          end
        end
      end
    end
  end
end

vim.cmd [[
  augroup RainbowBrackets
    autocmd!
    autocmd BufEnter,BufWinEnter,TextChanged,TextChangedI * lua rainbow_brackets()
  augroup END
]]

-- ===============================
--  Smart autopairs with Backspace deletion
-- ===============================
local autopairs = {
  ["{"] = "}",
  ["["] = "]",
  ["("] = ")",
  ["'"] = "'",
  ['"'] = '"',
  ["`"] = "`",
  ["<"] = ">"
}

for open, close in pairs(autopairs) do
  vim.keymap.set("i", open, function()
    local line = vim.fn.getline(".")
    local col = vim.fn.col(".")
    local prev_char = col > 1 and line:sub(col-1,col-1) or ""
    local next_char = line:sub(col,col)

    if next_char == close then
      return open..close.."<Left>"
    end
    if prev_char == open then
      return open..close.."<Left>"
    end
    return open..close.."<Left>"
  end, { expr=true, noremap=true })
end

-- Backspace deletes pair
vim.keymap.set("i", "<BS>", function()
  local col = vim.fn.col(".")
  local line = vim.fn.getline(".")
  local prev_char = col > 1 and line:sub(col-1, col-1) or ""
  local next_char = line:sub(col, col)
  if autopairs[prev_char] == next_char then
    return "<Del><BS>"
  end
  return "<BS>"
end, {expr=true, noremap=true})

-- ===============================
--  Treesitter highlighting
-- ===============================
local ok, ts = pcall(require, "nvim-treesitter.configs")
if ok then
  ts.setup {
    ensure_installed = {
      "javascript", "typescript",
      "c", "python", "lua",
      "d", "nasm", "fasm",
      "html", "css", "bash"
    },
    highlight = { enable = true },
  }
else
  vim.cmd("syntax enable")
end

-- ===============================
--  LSP setup
-- ===============================
local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if lspconfig_ok then
  local servers = {
    "pyright",       -- Python
    "clangd",        -- C/C++
    "tsserver",      -- JS/TS
    "html",          -- HTML
    "cssls",         -- CSS
    "bashls",        -- Bash
    "lua_ls",        -- Lua
    "d_language_server" -- Dlang
  }
  for _, lsp in ipairs(servers) do
    lspconfig[_].setup{}
  end
end

-- Autoformat on save
vim.cmd [[
  augroup FormatOnSave
    autocmd!
    autocmd BufWritePre * lua vim.lsp.buf.format({ async = false })
  augroup END
]]

-- ===============================
--  Highlight TODO/FIXME/NOTE
-- ===============================
vim.cmd [[
  syntax match TodoComment /\v<(TODO|FIXME|NOTE):?/
  highlight TodoComment guifg=#e5c07b ctermfg=Yellow gui=bold
]]

-- ===============================
--  Mini-outline: current function/class in statusline
-- ===============================
_G.current_function = function()
  local ok, ts_utils = pcall(require, "nvim-treesitter.ts_utils")
  if not ok then return "" end
  local node = ts_utils.get_node_at_cursor()
  while node do
    local type = node:type()
    if type == "function_definition" or type == "function_declaration" or type == "class_definition" then
      return ts_utils.get_node_text(node)[1] or ""
    end
    node = node:parent()
  end
  return ""
end

vim.o.statusline = "%f %h%m%r %{v:lua.current_function()} %=%-14.(%l,%c%V%) %P"

-- ===============================
--  Simple color scheme
-- ===============================
vim.cmd [[
  hi Normal guibg=NONE ctermbg=NONE
  hi Comment guifg=#606060 ctermfg=DarkGray
  hi String guifg=#98c379
  hi Function guifg=#61afef
  hi Keyword guifg=#c678dd
]]

print("Smart Neovim config loaded ✅")
