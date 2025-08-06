vim.opt.background = "dark"

-- This configuration options should be placed before `colorscheme sonokai`.
vim.g.sonokai_style = "shusia"
vim.g.sonokai_better_performance = 1
vim.g.sonokai_transparent_background = 2

vim.cmd.colorscheme("sonokai")

local highlight = vim.api.nvim_set_hl

-- Red Highlight the Matching Scope Character () [] {} ...
highlight(0, "MatchParen", { bold = true, fg = "#ff3333", bg = "none" })

-- Blue and Gray for Tabline (Overriding colorscheme ones)
highlight(0, "TablineSel", { fg = "#88ffff", bg = "#323232" })
highlight(0, "Tabline", { fg = "#989898", bg = "#252525" })

-- Highlight tabs
highlight(0, "HighlightTab", { fg = "#000000", bg = "#6666cc" })

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
    pattern = '*',
    callback = function()
        vim.fn.matchadd("HighlightTab", '\t')
    end
})
-- Highlight Trailing White Spaces
highlight(0, "TrailingWhitespace", { fg = "#000000", bg = "#666666" })

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
    pattern = '*',
    callback = function()
        vim.fn.matchadd('TrailingWhitespace', '\\s\\+$')
    end
})
