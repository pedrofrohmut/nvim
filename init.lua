vim.g.mapleader = " " -- Why this is the first line? Avoid weird bugs

vim.pack.add({
  "https://github.com/sainnhe/sonokai", -- My colorscheme
})

require("colors")
require("autocmd")
require("options")
require("keybinds")
