-- Neovide

-- Transparent background
-- vim.g.neovide_transparency = 0.9
-- vim.api.nvim_set_hl(0, "Normal", { bg = "#1a1b2c" })
--
-- -- Font without ligatures
-- vim.o.guifont = "Fira Mono Medium:h12"
--
-- -- Disable cursor animations (Make it just like terminal neovim)
-- vim.g.neovide_cursor_animation_length = 0
-- vim.g.neovide_cursor_trail_size = 0

vim.g.neovide_opacity = 0.9
vim.api.nvim_set_hl(0, "Normal", { bg = "#1a1b2c" })
vim.o.guifont = "FiraMono Nerd Font Medium:h11"
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_cursor_trail_size = 0
