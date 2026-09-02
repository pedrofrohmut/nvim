--[[

  Requirements

  Neovim 0.12.0 or later (nightly)
  `tar` and `curl` in your path
  `tree-sitter-cli` (0.26.1 or later, installed via your package manager, not npm)
  a C compiler in your path (see https://docs.rs/cc/latest/cc/#compile-time-requirements)

]]

local treesitter = require("nvim-treesitter")

treesitter.setup({
    -- $HOME/.local/share/nvim/data/site
    install_dir = vim.fn.stdpath("data") .. "/site"
})

treesitter.install({
    "c", "lua", "vim", "vimdoc", "query",
    "python", "c_sharp",
})
