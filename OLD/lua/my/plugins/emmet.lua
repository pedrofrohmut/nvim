-- Emmet Config

vim.g.user_emmet_mode = 'inv'
vim.g.user_emmet_leader_key = '<A-y>'
vim.api.nvim_create_autocmd("FileType", { pattern = "*", command = "EmmetInstall" })

vim.keymap.set("i", "<C-Space>", "<Plug>(emmet-expand-abbr)", { silent = true })
vim.keymap.set("v", "<C-Space>", "<Plug>(emmet-expand-abbr)", { silent = true })

--[[
Main commands
  1. Insert <C-y>,   emmet-expand-abbr
  2. Visual v_<C-y>, emmet-wrap-with-abbreviation
  3. Normal <C-y>u   emmet-update-tag
  4. Normal <C-y>/   emmet-toggle-comment
  4. lorem{n}        emmet-lorem-ipsum
]]
