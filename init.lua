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
    - Colorizer
    - Is nerdtree needed
    - Add emmet
    - AI autocomplete

    LSP
    X Mason
    X Auto complete
    X Snippets
    - LSP config
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
    "https://github.com/nvim-lualine/lualine.nvim", -- Lualine: Statusline
    "https://github.com/Bekaboo/dropbar.nvim", -- Breadcrumbs

    -- CMP Stuff
    "https://github.com/hrsh7th/nvim-cmp",
    "https://github.com/hrsh7th/cmp-nvim-lsp",
    "https://github.com/hrsh7th/cmp-buffer",
    "https://github.com/hrsh7th/cmp-path",

    -- Lua Snip
    "https://github.com/L3MON4D3/LuaSnip",
    "https://github.com/saadparwaiz1/cmp_luasnip",

    -- CMP not required (trying out)
    "https://github.com/hrsh7th/cmp-cmdline",
    "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help",
})

vim.api.nvim_create_user_command("PackUpdate", function()
    vim.pack.update()
end, { desc = "Vim Pack Update Packages" })

vim.api.nvim_create_user_command("PackList", function()
    local packs = vim.iter(vim.pack.get())
        :map(function(x) return x.spec.name end)
        :totable()
    -- print(packs)
    local my = require("my-custom")
    my.debug_big(packs)
end, { desc = "Vim Pack List Packages" })

-- Vim Config
require("colors")
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
require("plugins/git-signs")
require("plugins/statusline-winbar")
require("plugins/nvim-cmp")
