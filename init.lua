-- Vim Plug to install packages

local Plug = vim.fn["plug#"]

vim.call("plug#begin")

Plug("nvim-lua/plenary.nvim")
Plug("nvim-telescope/telescope-fzf-native.nvim", { ["do"] = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install" })
Plug("nvim-telescope/telescope.nvim")
Plug("preservim/nerdtree")
Plug("justinmk/vim-sneak")
Plug("mattn/emmet-vim")
Plug("nvim-lualine/lualine.nvim")
Plug("tpope/vim-surround")
Plug("tpope/vim-repeat")
Plug("tommcdo/vim-lion")
Plug("sainnhe/sonokai")

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

-- # LSP ----------------------------------------------------------------------

-- TODO: Add nvim-lsp, mason, cmp, luasnip, linter, formatter, outline, jsx-pretty

-- # Debug --------------------------------------------------------------------

-- TODO: Add dap and dap-ui
