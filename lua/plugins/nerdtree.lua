local ignores = {
    "node_modules",
    "obj$",
    "bin$",
    "target",
    "__pycache__",
    ".git",
    ".dist",
    ".next",
    "dist",
    "deps",
    "_build",
    ".elixir_ls",
    "\\.out$",
    "\\.exe$",
    ".lock",
    "package-lock.json",
    ".expo",
    "build/",
    ".gradle",
    "gradle",
    ".settings",
    ".project",
    ".classpath",
    ".mvn",
    "mvnw",
    "mvnw.cmd",
}

vim.g.NERDTreeIgnore = ignores
vim.g.NERDTreeWinSize = 48
vim.g.NERDTreeHijackNetrw = false
vim.g.NERDTreeShowHidden = true
vim.g.NERDTreeMinimalUI = true
vim.g.NERDTreeMinimalMenu = true
vim.g.NERDTreeShowHidden = true

vim.keymap.set("n", "<leader>ft", function()
    vim.cmd("NERDTreeFind")
    vim.cmd("NERDTreeRefreshRoot")
end, { desc = "NERDTree Tree Find && Refresh" })

vim.keymap.set("n", "<leader>tt", function()
    vim.cmd("NERDTreeToggle")
    vim.cmd("NERDTreeRefreshRoot")
end, { desc = "NERDTree Tree Toggle && Refresh" })

-- Refresh NERDTree on buf write and buff focus
-- vim.api.nvim_create_autocmd("BufWritePost", { pattern = "*", command = "NERDTreeRefreshRoot" })
vim.api.nvim_create_autocmd("BufEnter", { pattern = "NERD_tree_tab_*", command = "NERDTreeRefreshRoot" })
