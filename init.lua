-- ===============================
--  Smart minimal Neovim config
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
--  Smart auto pairs
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
    local prev_char = col > 1 and line:sub(col - 1, col - 1) or ""
    local next_char = line:sub(col, col)

    -- if cursor is inside pair -> insert nested pair
    if next_char == close then
      return open .. close .. "<Left>"
    end

    -- if same opener before, stack pairs like IDEs
    if prev_char == open then
      return open .. close .. "<Left>"
    end

    return open .. close .. "<Left>"
  end, { expr = true, noremap = true })
end

-- ===============================
--  Syntax highlighting
-- ===============================
local ok, ts = pcall(require, "nvim-treesitter.configs")
if ok then
  ts.setup {
    ensure_installed = {
      "javascript", "typescript",
      "c", "python", "lua",
      "d", "nasm", "fasm"
    },
    highlight = { enable = true },
  }
else
  vim.cmd("syntax enable")
end

-- ===============================
--  Simple color scheme
-- ===============================
vim.cmd [[
  hi Normal guibg=NONE ctermbg=NONE
  hi CursorLine cterm=bold guibg=#1f1f1f
  hi Comment ctermfg=DarkGray guifg=#606060
  hi String guifg=#98c379
  hi Function guifg=#61afef
  hi Keyword guifg=#c678dd
]]

print("Smart Neovim config loaded ✅")
