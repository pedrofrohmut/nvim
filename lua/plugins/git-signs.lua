local gs = require("gitsigns")
local map = vim.keymap.set
local cmd = vim.api.nvim_create_user_command
local highlight = vim.api.nvim_set_hl

highlight(0, "GitSignsAddInLine", { fg = "#9ed072" }) -- Green for additions
highlight(0, "GitSignsChangeInLine", { fg = "#e6c384" }) -- Yellow for changes
highlight(0, "GitSignsDeleteInLine", { fg = "#c34043" }) -- Red for deletions

gs.setup({
    preview_config = {
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
    },
})

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
