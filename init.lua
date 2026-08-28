vim.g.mapleader = " " -- Why this is the first line? Avoid weird bugs

-- # Vim Config ----------------------------------------------------------------
require("vim-pack")
require("autocmd")
require("options")
require("keybinds")
require("my-custom")
require("utils")

-- # Plugins Config ------------------------------------------------------------
require("plugins/mason")
require("plugins/lsp")
require("plugins/vim-surround")
require("plugins/sneak")
require("plugins/treesitter")
require("plugins/telescope")
require("plugins/lualine")
require("plugins/nvim-cmp")
require("plugins/emmet-vim")
require("plugins/conform")
require("plugins/lint")
require("plugins/symbols-outline")
require("plugins/nerdtree")
require("plugins/dap")
-- require("plugins/minuet-ai")
-- require("plugins/git-signs")
require("plugins/nvim-repl")

-- # Colors --------------------------------------------------------------------
-- require("colors")
require("alt-colors")
-- require("simple-colors")
