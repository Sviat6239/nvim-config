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
--  Rainbow brackets
-- ===============================
-- 8 colors
local colors = {
  "#e06c75", "#d19a66", "#e5c07b", "#98c379",
  "#56b6c2", "#61afef", "#c678dd", "#be5046"
}

for i, color in ipairs(colors) do
  vim.cmd(string.format("highlight Rainbow%d guifg=%s", i, color))
end

local brackets = {"(", "[", "{"}

-- make function global so autocmd can see it
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

-- autocmd to update rainbow brackets
vim.cmd [[
  augroup RainbowBrackets
    autocmd!
    autocmd BufEnter,BufWinEnter,TextChanged,TextChangedI * lua rainbow_brackets()
  augroup END
]]

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
