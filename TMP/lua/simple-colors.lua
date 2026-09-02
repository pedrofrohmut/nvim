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
    purple = "#c299ff",
}

-- vim.cmd("highlight clear")
-- vim.cmd("syntax reset")

vim.o.background = "dark"

local hl = vim.api.nvim_set_hl

hl(0, "Normal",     { fg = "#cecece" })
hl(0, "Comment",    { fg = colors.blue })
hl(0, "Constant",   { fg = "#cecece" })
hl(0, "String",     { fg = colors.lightgreen })
hl(0, "Character",  { fg = "#cecece" })
hl(0, "Number",     { fg = colors.purple })
hl(0, "Boolean",    { fg = "#cecece" })
hl(0, "Float",      { fg = "#cecece" })
hl(0, "Function",   { fg = "#cecece" })
hl(0, "Identifier", { fg = "#cecece" })
hl(0, "Keyword",    { fg = "#cecece" })
hl(0, "Statement",  { fg = "#cecece" })
hl(0, "Operator",   { fg = "#cecece" })
hl(0, "Type",       { fg = "#cecece" })
hl(0, "PreProc",    { fg = "#cecece" })
hl(0, "Special",    { fg = "#cecece" })
hl(0, "Underlined", { fg = "#cecece" })
hl(0, "Error",      { fg = "#cecece" })
hl(0, "Todo",       { fg = "#cecece" })
hl(0, "LineNr",     { fg = "#cecece" })
hl(0, "CursorLine", { bg = "#323232" })
hl(0, "StatusLine", { fg = "#cecece" })
hl(0, "Search",     { fg = "#cecece", bg = "#3a3a3a" })

-- TreeSitter ------------------------------------------------------------------

hl(0, "@keyword",  { link = "Keyword" })
hl(0, "@string",   { link = "String" })
hl(0, "@function", { link = "Function" })
hl(0, "@type",     { link = "Type" })
hl(0, "@comment",  { link = "Comment" })
hl(0, "@constant", { link = "Constant" })
hl(0, "@number",   { link = "Number" })
hl(0, "@boolean",  { link = "Boolean" })
hl(0, "@float",    { link = "Float" })
hl(0, "@operator", { link = "Operator" })
hl(0, "@variable", { link = "Identifier" })

vim.g.colors_name = "simple"
