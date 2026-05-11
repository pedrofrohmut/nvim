require("outline").setup({})

vim.keymap.set("n", "<leader>ts", vim.cmd.Outline, { desc = "Toggle Outline Symbols" })

--require("symbols-outline").setup({
--      position = "right",
--      width = 25,
--      -- Keymaps are default just here to be easy to find
--      keymaps = { -- These keymaps can be a string or a table for multiple keys
--        close = {"<Esc>", "q"},
--        goto_location = "<Cr>",
--        focus_location = "o",
--        hover_symbol = "<C-space>",
--        toggle_preview = "K",
--        rename_symbol = "r",
--        code_actions = "a",
--        fold = "h",
--        unfold = "l",
--        fold_all = "W",
--        unfold_all = "E",
--        fold_reset = "R",
--      },
--})
--
--vim.keymap.set("n", "<F8>", vim.cmd.SymbolsOutline, { silent = true })
