vim.g.NERDTreeIgnore = {
    "node_modules",
    "obj",
    "bin",
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
vim.g.NERDTreeWinSize = 48
vim.g.NERDTreeHijackNetrw = false
vim.g.NERDTreeShowHidden = true
vim.g.NERDTreeMinimalUI = true
vim.g.NERDTreeMinimalMenu = true

vim.keymap.set("n", "<leader>ft", "<cmd>NERDTreeFind<Enter><cmd>NERDTreeRefreshRoot<Enter>", { desc = "NERDTree Tree Find && Refresh" })
vim.keymap.set("n", "<leader>tt", "<cmd>NERDTreeToggle<Enter><cmd>NERDTreeRefreshRoot<Enter>", { desc = "NERDTree Tree Toggle && Refresh" })
