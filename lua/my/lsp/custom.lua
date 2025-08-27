local preview_win = function(lines)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
    vim.api.nvim_buf_set_option(buf, "swapfile", false)
    vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
    vim.api.nvim_buf_set_option(buf, "modifiable", false)
    vim.api.nvim_buf_set_option(buf, "filetype", "lua") -- For syntax highlighting

    local win = vim.api.nvim_open_win(buf, false, {
        relative = "editor",
        width = vim.api.nvim_get_option("columns"),
        height = 10,
        row = vim.api.nvim_get_option("lines") - math.min(#lines, 25) - 1,
        col = vim.api.nvim_get_option("columns"),
        style = "minimal",
        border = "single",
    })

    -- Set window options
    vim.api.nvim_win_set_option(win, "number", false)
    vim.api.nvim_win_set_option(win, "relativenumber", false)
    vim.api.nvim_win_set_option(win, "wrap", true)
end

local debug = function(result)
    -- Use vim.inspect for pretty printing
    local inspected = vim.inspect(result, { depth = 10 })

    -- Split into lines and show in preview
    local lines = vim.split(inspected, "\n")

    preview_win(lines)
end

local foo = function()
    local params = vim.lsp.util.make_position_params(0, "utf-8")

    vim.lsp.buf_request(0, "textDocument/signatureHelp", params, function(err, result, ctx, config)
        if err ~= nil then
            vim.notify("Signature help error: " .. err.message, vim.log.levels.ERROR)
            return
        end

        if result == nil or result.signatures == nil or result.signatures[1] == nil then
            print("No signature help found")
            return
        end

        local lines = { result.signatures[1].label }
        preview_win(lines)
    end)
end

vim.keymap.set("n", "<leader>h", foo)
vim.keymap.set("i", "<C-a>", foo)

return {
    debug
}
