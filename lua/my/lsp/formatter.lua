require("conform").setup({
    formatters_by_ft = {
        css = { "prettier" },
        graphql = { "prettier" },
        html = { "prettier" },
        vue = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        json = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier" },
        python = { "isort", "black" },
        svelte = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        yaml = { "prettier" },
    },
})

vim.keymap.set("n", "<leader>gf", require("conform").format)
