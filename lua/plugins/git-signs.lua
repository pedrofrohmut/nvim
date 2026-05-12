local gs = require("gitsigns")
local map = vim.keymap.set
local cmd = vim.api.nvim_create_user_command

-- Navigation
map("n", "]g", function()
    gs.nav_hunk("next")
end, { desc = "Next git hunk" })
map("n", "[g", function()
    gs.nav_hunk("prev")
end, { desc = "Previous git hunk" })

-- Manipulate Hunks
map("n", "<leader>hp", function()
    gs.preview_hunk()
end, { desc = "Preview hunk" })
cmd("GSStageHunk", function()
    gs.stage_hunk()
end, { desc = "Stage hunk" })
cmd("GSResetHunk", function()
    gs.reset_hunk()
end, { desc = "Reset hunk" })

-- Blame
map("n", "<leader>hb", function()
    gs.blame_line({ full = true })
end, { desc = "Blame line" })
map("n", "<leader>hB", function()
    gs.toggle_current_line_blame()
end, { desc = "Toggle inline blame" })

-- View Diff
cmd("GSDiff", function()
    gs.diffthis()
end, { desc = "Diff this" })
