local lint = require("lint")

lint.linters_by_ft = {
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    typescriptreact = { "eslint_d" },
    svelte = { "eslint_d" },
    python = { "pylint" },
}

local lint_enabled = false

local toggler = function()
    if lint_enabled then
        vim.notify("Lint is turned off")
        lint_enabled = false
    else
        vim.notify("Lint is turned on")
        lint_enabled = true
    end
end

vim.keymap.set("n", "<leader>cl", toggler, { desc = "Toggle Lint on Save" })

-- Autocmd to run linter on file save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        if lint_enabled then
            lint.try_lint()
        end
    end,
})

-- Old stuff
-- Autocmd to run linter on file save
--vim.api.nvim_create_autocmd({ "BufWritePost" }, { callback = lint.try_lint })
-- vim.keymap.set("n", "<leader>cl", lint.try_lint, { desc = "Run code Linter" })
