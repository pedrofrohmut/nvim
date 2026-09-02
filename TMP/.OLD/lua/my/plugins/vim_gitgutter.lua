-- airblade/vim-gitgutter

-- Disable git gutter default mappings
vim.g.gitgutter_map_keys = 0

vim.keymap.set("n", "[g", "<cmd>GitGutterPrevHunk<Enter>")
vim.keymap.set("n", "]g", "<cmd>GitGutterNextHunk<Enter>")
