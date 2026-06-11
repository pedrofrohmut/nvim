local highlight = vim.api.nvim_set_hl

local colors = {
    -- My colors
    yellow = "#e5c463", -- Sonokai yellow
    red = "#f85e84", -- Sonokai red
    blue = "#557799", -- My blue comments
    lightgray = "#cecece", -- Emacs default
    gray = "#676767",

    -- Extra colors
    darkgray = "#242424",
    green = "#234d3d",
    lightgreen = "#9ece6a",
    lightblue = "#61afef",
}

-- My Own Colorscheme
highlight(0, "Normal", { fg = colors.lightgray, bg = "none" })
highlight(0, "NormalNC", {}) -- For inactive windows
highlight(0, "Comment", { fg = colors.blue })
highlight(0, "Constant", {})
highlight(0, "String", { fg = colors.yellow })
highlight(0, "Character", {})
highlight(0, "Number", {})
highlight(0, "Boolean", {})
highlight(0, "Float", {})
highlight(0, "Function", {})
highlight(0, "Identifier", {})
highlight(0, "Statement", { fg = colors.red })
highlight(0, "Conditional", {})
highlight(0, "Repeat", {})
highlight(0, "Label", {})
highlight(0, "Operator", {})
highlight(0, "Keyword", { fg = colors.red })
highlight(0, "Exception", {})
highlight(0, "Type", {})
highlight(0, "StorageClass", {})
highlight(0, "Structure", {})
highlight(0, "Typedef", {})
highlight(0, "Special", {})
highlight(0, "Underlined", {})
highlight(0, "Ignore", {})
highlight(0, "Error", {})
highlight(0, "Todo", {})
highlight(0, "LineNr", { fg = colors.gray })
highlight(0, "CursorLineNr", { fg = colors.yellow })
highlight(0, "NonText", {})
highlight(0, "SpecialKey", {})
highlight(0, "Directory", {})
highlight(0, "Title", {})

-- Debug
highlight(0, "debugPC", { bg = colors.green, fg = colors.lightgray })

-- Dap signs highlight groups
highlight(0, "DapBreakpoint", { fg = colors.yellow })
highlight(0, "DapBreakpointCondition", { fg = colors.yellow })
highlight(0, "DapLogPoint", { fg = colors.yellow })
highlight(0, "DapStopped", { fg = colors.yellow, bg = colors.green })
highlight(0, "DapBreakpointRejected", { fg = colors.yellow })

-- applying highlight groups
vim.fn.sign_define("DapBreakpoint", {text="B", texthl="DapBreakpoint", linehl="", numhl=""})
vim.fn.sign_define("DapBreakpointCondition", {text="C", texthl="DapBreakpointCondition", linehl="", numhl=""})
vim.fn.sign_define("DapLogPoint", {text="L", texthl="DapLogPoint", linehl="", numhl=""})
vim.fn.sign_define("DapStopped", {text="→", texthl="DapStopped", linehl="debugPC", numhl="debugPC"})
vim.fn.sign_define("DapBreakpointRejected", {text="R", texthl="DapBreakpointRejected", linehl="", numhl=""})

-- Red Highlight the Matching Scope Character () [] {} ...
highlight(0, "MatchParen", { bold = true, fg = "#ff3333", bg = "none" })

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

-- Vim JSX Pretty --------------------------------------------------------------

vim.g.vim_jsx_pretty_enable_jsx_highlight = 0
