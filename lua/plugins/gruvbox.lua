vim.g.gruvbox_contrast_dark = "soft"
vim.g.gruvbox_contrast_light = "soft"
vim.g.gruvbox_transparent_bg = 1
vim.cmd("colorscheme gruvbox")

local highlight = vim.api.nvim_set_hl

highlight(0, "Normal", { bg = "None" })
highlight(0, "NonText", { bg = "none" })
highlight(0, "EndOfBuffer", { bg = "none" })
highlight(0, "LineNr", { fg = "#676767", bg = "none" })
highlight(0, "SignColumn", { bg = "none" })
