-- REPL Nvim

vim.keymap.set("v", "<leader>rv", "<Plug>(ReplSendVisual)")
vim.keymap.set("n", "<leader>rl", "<Plug>(ReplSendLine)")
vim.keymap.set("n", "<leader>rc", "<Plug>(ReplSendCell)")

vim.keymap.set("n", "<leader>rr", "<cmd>ReplClear<CR>")
