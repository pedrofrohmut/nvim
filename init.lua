-- Vim Plug to install packages

local Plug = vim.fn["plug#"]

vim.call("plug#begin")

Plug("nvim-lua/plenary.nvim")
Plug(
    "nvim-telescope/telescope-fzf-native.nvim",
    { ["do"] = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install" }
)
Plug("nvim-telescope/telescope.nvim")
Plug("preservim/nerdtree") -- Tree file explorer
Plug("justinmk/vim-sneak") -- Text Jumping Enhancement
Plug("mattn/emmet-vim") -- Easy Tags
Plug("nvim-lualine/lualine.nvim") -- Status line
Plug("tpope/vim-surround") -- Change, add and remove surround symbols
Plug("tpope/vim-repeat") -- Dot works for more stuff
Plug("tommcdo/vim-lion") -- Vertical Aligner
Plug("MaxMEllon/vim-jsx-pretty") -- Indentation for react
Plug("stevearc/conform.nvim") -- Conform: Code Formatter
Plug("mfussenegger/nvim-lint") -- Nvim-Lint
Plug("hedyhli/outline.nvim") -- Symbols outline
Plug("nvim-treesitter/nvim-treesitter") -- Treesitter

Plug("sainnhe/sonokai") -- Main colorscheme
Plug("morhetz/gruvbox")

-- Lua Snip
Plug("L3MON4D3/LuaSnip")
Plug("saadparwaiz1/cmp_luasnip")
Plug("rafamadriz/friendly-snippets")

-- CMP
Plug("hrsh7th/nvim-cmp")
Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-buffer")
Plug("hrsh7th/cmp-path")

-- LSP
Plug("mason-org/mason.nvim")
Plug("neovim/nvim-lspconfig")

-- Debug
Plug("mfussenegger/nvim-dap") -- DAP impl for neovim
Plug("nvim-neotest/nvim-nio") -- Required for DapUI
Plug("rcarriga/nvim-dap-ui") -- UI for debugging

vim.call("plug#end")

vim.g.mapleader = " "


-- # Vim -----------------------------------------------------------------------

require("autocmd")
require("options")
require("keybinds")
require("my-custom")
require("utils")
require("colors")

-- # Plugins -------------------------------------------------------------------

require("plugins/nerdtree")
require("plugins/telescope")
require("plugins/sneak")
require("plugins/emmet")
require("plugins/lualine")
require("plugins/vim-surround")
require("plugins/conform")
require("plugins/lint")
require("plugins/treesitter")
require("plugins/jsx-prettier")

-- # LSP ----------------------------------------------------------------------

require("plugins/nvim-cmp")
require("plugins/mason")
require("plugins/lsp")
require("plugins/symbols-outline")

-- # Debug --------------------------------------------------------------------

-- TODO: Add dap and dap-ui

-- Color Scheme ----------------------------------------------------------------

require("plugins/sonokai")
-- require("plugins/gruvbox")
