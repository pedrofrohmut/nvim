local navic = require("nvim-navic")

navic.setup({})

vim.opt.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
