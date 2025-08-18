-- Modes for key mappings in Neovim:
-- "i" = Insert mode
-- "n" = Normal mode
-- "v" = Visual mode
-- "x" = Visual block mode
-- "t" = Terminal mode
-- "c" = Command mode
-- "o" = Operator-pending mode

local map = vim.keymap.set

-- Unsetters: Do nothing to remove unwanted default behavior
map("n", "R", "<Nop>") -- Disable WTF mode
map("i", "<C-i>", "<Nop>") -- Can use C-i for completions

-- Indent
map({ "n", "v" }, "<Space><Space>", "=")

-- Function Keys
map("n", "<F1>", ":vertical help ")
map("n", "<F2>", ":verbose map ")

-- Easy Register Copy/Cut to/from System Clipboard (:checkhealth if not working)
map("v", "<leader>sy", '"+y')
map("v", "<leader>sd", '"+d')
map("n", "<leader>sp", '"+p')

-- Do not override current register on v_paste
map("v", "p", [["_dP]])

-- Redo on better keymapping
map("n", "U", "<C-r>")

-- Reset /Cleanup UI
local cleanup = function()
    for _, window_id in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_config(window_id).relative ~= "" then
            vim.api.nvim_win_close(window_id, false)
        end
    end
    vim.cmd("set cmdheight=1")
    vim.cmd("echo ''")
end
map("n", "<C-c>", cleanup)
map("n", "<Esc>", cleanup)

-- Delete in insert and command mode
map({ "i", "c" }, "<C-l>", "<Del>")
map({ "i", "c" }, "<C-h>", "<BS>")

-- Insert lines in Normal Mode
map("n", "<Enter>", "i<Enter><Esc>")
map("n", "<C-Space>", "i<Space><Esc>")

-- Insert ; at line end (Lazy nerd)
map("n", "<leader>;", "mzA;<Esc>`z")

-- Quickfix (use [q ]q to next and prev)
map("n", "<leader>qq", vim.cmd.cclose)
map("n", "<leader>qo", vim.cmd.copen)

-- Toggle wrap and linebreak
map("n", "<leader>zl", function()
    local is_wrap_on = vim.wo.wrap
    vim.wo.wrap = not is_wrap_on
    vim.wo.linebreak = not is_wrap_on
    if is_wrap_on then
        vim.notify("Line wrap is off")
    else
        vim.notify("Line wrap is on")
    end
end)

-- Language-Aware Inline Comment
map("n", "gcl", function()
    local cs = vim.bo.commentstring
    local symbol = cs:sub(0, -4)

    local curr_line = vim.fn.getline(".")

    if curr_line == "" then
        vim.api.nvim_feedkeys("i" .. symbol .. " ", "n", false)
    else
        vim.api.nvim_feedkeys("A " .. symbol .. " ", "n", false)
    end
end)

-- MyPlugin: Closing cheracter -------------------------------------------------

-- Closing character with <Enter> / <CR>
map("i", "(<CR>", "(<CR>)<Esc>ko")
map("i", "[<CR>", "[<CR>]<Esc>ko")
map("i", "[[<CR>", "[[<CR>]]<Esc>ko")
map("i", "{<CR>", "{<CR>}<Esc>ko")
map("i", "({<CR>", "({<CR>})<Esc>ko")
map("i", "`<CR>", "`<CR>`<Esc>ko<Tab>")
map("i", "(`<CR>", "(``)<Esc>hi<CR><Esc>ko<Tab>")

-- Add spaces inside closing character (lacking in autopairs plugin)
map("i", "( ", "(  )<Esc>hi")
map("i", "[ ", "[  ]<Esc>hi")
map("i", "[[ ", "[[  ]]<Esc>hi")
map("i", "{ ", "{  }<Esc>hi")
map("i", "({ ", "({  })<Esc>hi")

-- Buffers ---------------------------------------------------------------------

map("n", "[b", vim.cmd.bprevious)
map("n", "]b", vim.cmd.bnext)
map("n", "<leader>bb", ":buffers<CR>:b ")
map("n", "<leader>ba", ":%bd")
map("n", "gb", "<cmd>b#<CR>")

-- Tabs ------------------------------------------------------------------------

-- New Tab
map("n", "<leader>tc", ":tabnew<CR>", { silent = true })

-- Close Tabs
map("n", "<leader>tq", ":tabclose<CR>", { silent = true })
map("n", "<leader>to", ":tabonly<CR>", { silent = true })

-- Move Tabs - Left/Right
map("n", "<leader>th", ":-tabmove<CR>", { silent = true })
map("n", "<leader>tl", ":+tabmove<CR>", { silent = true })

-- Go To - Next/Prev
map("n", "<C-n>", ":tabnext<CR>", { silent = true })
map("n", "<C-p>", ":tabprevious<CR>", { silent = true })

-- Windows ---------------------------------------------------------------------

-- Resizing
map("n", "<Up>", "3<C-w>+") -- Up
map("n", "<Down>", "3<C-w>-") -- Down
map("n", "<Left>", "3<C-w>>") -- Left
map("n", "<Right>", "3<C-w><") -- Right

-- Change current window to a new tab
map("n", "<leader>wt", "<C-w>T")

-- Closes every other window and every other tab
map("n", "<leader>wo", function()
    vim.cmd.tabonly()
    vim.cmd.only()
    vim.cmd.echo("''")
end, { desc = "Close other tabs and other windows" })

-- Jumping/Scrolling -----------------------------------------------------------

map({ "n", "v" }, "M", "%") -- Easier to press %
map({ "n", "v" }, "H", "^") -- First non-blank character
map({ "n", "v" }, "L", "g_") -- Last non-blank character

-- Emacs inspired maps
map({ "n", "v" }, "<A-a>", "k^") -- First character of previous line
map({ "n", "v" }, "<A-e>", "2$") -- Last character of next line

-- Scrolling Vertical
map({ "n", "v" }, "<C-k>", "12<C-y>")
map({ "n", "v" }, "<C-j>", "12<C-e>")

-- Scrolling Vertical 2x
map({ "n", "v" }, "<C-d>", "28<C-e>M")
map({ "n", "v" }, "<C-u>", "28<C-y>M")

-- Scrolling Vertical (InsertMode)
map("i", "<C-b>", "<C-o>zz")
map("i", "<C-x><C-k>", "<C-o>12<C-y>")
map("i", "<C-x><C-j>", "<C-o>12<C-e>")

-- Scrolling Horizontal
map({ "n", "v" }, "<C-h>", "3zh")
map({ "n", "v" }, "<C-l>", "3zl")

-- Center when jumping
map("n", "`0", "`0zz")
map("n", "'0", "'0zz")

-- String Utils ----------------------------------------------------------------

-- Find-Replace
map("n", "<leader>ss", ":%s/")
map("v", "<leader>ss", ":s/")

-- Find-Replace but auto-fills the with last yanked
map("n", "<leader>sh", ':%s/<C-r>"/')
map("v", "<leader>sh", 'y<Esc>:%s/<C-r>"/')

-- Sort
map("v", "<leader>sp", ":sort<Enter>")

-- Remove trailing spaces
map("n", "<leader>st", function()
    local ok, _ = pcall(vim.cmd, [[ execute '%s/\s\+$' ]])
    if ok then
        print("Removed trailing white spaces")
    else
        print("No trailing white spaces to remove")
    end
end)

-- Change word case
map("n", "<leader>su", "g~iw") -- upcase inner word
map("n", "<leader>sU", "g~iW") -- upcase inner big word
map("n", "<leader>sl", "i_<Esc>l~") -- Camel Case to Snake Case
map("n", "<leader>sh", "dl~l") -- Snake Case to Camel Case

-- Terminal Mode ---------------------------------------------------------------

map("n", "<leader>xx", ":terminal zsh<CR>")
map("n", "<leader>xv", ":vs | terminal zsh<CR>")
map("n", "<leader>xs", ":sp | terminal zsh<CR>")

map("t", "<C-w><C-w>", "<C-\\><C-n><C-w>w")
