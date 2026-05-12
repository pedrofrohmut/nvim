require("nvim-treesitter").setup({
    install_dir = vim.fn.stdpath("data") .. "/site",
})

-- TODO: Check react code. It was bugged before with treesitter
require("nvim-treesitter").install({
    "rust",
    "java",
    "c_sharp",
    "python",
    "go",
    "javascript",
    "typescript",
    "tsx",
})
