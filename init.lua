vim.g.mapleader = " " -- Why this is the first line? Avoid weird bugs

--[[
    TODOs:

    Nvim
    X Treesitter update

    Plugins
    X Add a file explorer: like config netrw, add oil, check options later
    X Lualine
    X Check if auto-pairs is needed
    X Statusbar breadcrumbs
    X Telescope
    X AI autocomplete
    X Colorizer
    X Add emmet
    X Is nerdtree needed

    LSP
    X Mason
    X Auto complete
    X Snippets
    X LSP config
    X Formatter
    X Linter
    X Symbols outline (tagbar)
    - Debug
]]

-- Vim Config
require("vim-pack")
-- require("colors")
require("alt-colors")
require("autocmd")
require("options")
require("keybinds")
require("my-custom")

-- Plugins Config
require("plugins/mason")
require("plugins/lsp")
require("plugins/vim-surround")
require("plugins/sneak")
require("plugins/treesitter")
require("plugins/telescope")
-- require("plugins/git-signs")
require("plugins/lualine")
require("plugins/nvim-cmp")
-- require("plugins/minuet-ai")
require("plugins/emmet-vim")
require("plugins/conform")
require("plugins/lint")
require("plugins/symbols-outline")
require("plugins/nerdtree")
require("plugins/dap")
