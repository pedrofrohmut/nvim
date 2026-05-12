require("outline").setup({})

vim.keymap.set("n", "<leader>ts", vim.cmd.Outline, { desc = "Toggle Outline Symbols" })
