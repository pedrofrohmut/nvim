local lint = require("lint")

lint.linters_by_ft = {
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    typescriptreact = { "eslint_d" },
    svelte = { "eslint_d" },
    python = { "pylint" },
}

-- Autocmd to run linter on file save
--vim.api.nvim_create_autocmd({ "BufWritePost" }, { callback = lint.try_lint })

vim.keymap.set("n", "<leader>cl", lint.try_lint)
