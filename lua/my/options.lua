--[[
    VIM OPTIONS   :help options
]]

local opt          = vim.opt

-- Indentation and tabing
opt.expandtab      = true
opt.shiftwidth     = 4
opt.softtabstop    = 4
opt.tabstop        = 4
opt.smartindent    = true

-- Searching
opt.incsearch      = true
opt.hlsearch       = false

-- Appearance
opt.signcolumn     = "yes:1"
opt.colorcolumn    = { "81", "121" }
opt.cmdheight      = 1
opt.termguicolors  = true
opt.showmode       = false
opt.number         = true
opt.relativenumber = true
opt.wildmenu       = true
opt.termguicolors  = true

-- Behavior
opt.splitright     = true
opt.splitbelow     = true
--opt.sidescrolloff  = 8
opt.cursorline     = true
opt.mouse          = "a"
opt.updatetime     = 250
opt.wrap           = false
--opt.textwidth      = 100

-- Files
--opt.fileformat     = "unix" -- Bugs lazy.nvim
opt.backup         = false
opt.writebackup    = false
opt.autoread       = true

-- CMP
opt.completeopt    = { "menu", "menuone", "noselect" }

-- To Work with :find
vim.cmd[[ set path=.,** ]] -- Set path
vim.cmd[[ set path-=**/node_modules,.git/ ]]
opt.wildmenu = true
