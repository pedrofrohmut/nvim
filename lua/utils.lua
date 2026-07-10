vim.api.nvim_create_user_command("CopyMessages", function()
    vim.cmd('let @+ = execute("messages")')
end, { desc = "Copy :messages to system clipboard" })
