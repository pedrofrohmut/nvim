vim.g.mapleader = " " -- Why this is the first line? Avoid weird bugs

--[[
    TODOs:

    Nvim
    - Treesitter update

    Plugins
    - Add a file explorer: like config netrw, add oil, check options later
    - Add emmet
    - Check if auto-pairs is needed
    - Statusbar bread crumbs
    - Telescope
    - colorizer
    - Is nerdtree needed
    - Lualine

    LSP
    - LSP config
    - Auto complete
    - Snippets
    - Mason
    - Formatter
    - Debug
    - Symbols outline (tagbar)
]]

vim.pack.add({
  "https://github.com/sainnhe/sonokai", -- My colorscheme
  "https://github.com/tpope/vim-surround", -- Surround
  "https://github.com/tpope/vim-repeat", -- Better support for the dot operator
  "https://github.com/tommcdo/vim-lion", -- Vertical align text
  "https://github.com/justinmk/vim-sneak", -- Better f,F,t,T and word jumping
  "https://github.com/lewis6991/gitsigns.nvim", -- Git gutter
  "https://github.com/neovim/nvim-lspconfig", -- LSP Config
  "https://github.com/mason-org/mason.nvim", -- Mason: Install lsp servers, linters, formaters, debug adapters
  "https://github.com/mason-org/mason-lspconfig.nvim", -- Mason Lspconfig: Makes easier to use Mason + Lsp Config
  "https://github.com/nvim-treesitter/nvim-treesitter", -- Treesitter
  "https://github.com/nvim-lua/plenary.nvim", -- Required for Telescope
  "https://github.com/nvim-telescope/telescope.nvim", -- Telescope: Fuzzy Finder + UI
})

-- Vim Config
require("colors")
require("autocmd")
require("options")
require("keybinds")

-- Plugins Config
require("plugins/mason")
require("plugins/lsp")
require("plugins/vim-surround")
require("plugins/sneak")
require("plugins/treesitter")
require("plugins/telescope")
require("plugins/git-signs")
