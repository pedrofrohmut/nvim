require("codeium").setup({
    workspace_root = {
        use_lsp = false,
        find_root = function()
            vim.fn.getcwd()
        end,
    },
})
