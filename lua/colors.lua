-- # Colors --------------------------------------------------------------------

local highlight = vim.api.nvim_set_hl

vim.opt.background = "dark"
vim.opt.termguicolors = true

-- Red Highlight the Matching Scope Character () [] {} ...
highlight(0, "MatchParen", { bold = true, fg = "#ff3333", bg = "none" })

highlight(0, "ColorColumn", { bg = "#242424"})
highlight(0, "CursorLine", { bg = "#242424"})

-- Blue and Gray for Tabline (Overriding colorscheme ones)
highlight(0, "TablineSel", { fg = "#88ffff", bg = "#323232" })
highlight(0, "Tabline", { fg = "#989898", bg = "#252525" })

-- Highlight tabs
-- highlight(0, "HighlightTab", { fg = "#000000", bg = "#6666cc" })
highlight(0, "HighlightTab", { fg = "#676767", bg = "none" })
vim.cmd([[
  " Toggle on with 'set list'
  set listchars=tab:▸┈
]])

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = "*",
    callback = function()
        vim.fn.matchadd("HighlightTab", "\t")
    end,
})

-- Highlight Trailing White Spaces
highlight(0, "TrailingWhitespace", { fg = "#000000", bg = "#666666" })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = "*",
    callback = function()
        vim.fn.matchadd("TrailingWhitespace", "\\s\\+$")
    end,
})
