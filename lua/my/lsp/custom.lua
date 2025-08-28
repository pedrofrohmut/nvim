local preview_win = function(lines)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
    vim.api.nvim_buf_set_option(buf, "swapfile", false)
    vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
    vim.api.nvim_buf_set_option(buf, "modifiable", false)
    vim.api.nvim_buf_set_option(buf, "filetype", "lua") -- For syntax highlighting

    local width = vim.api.nvim_get_option("columns") - 80
    local win = vim.api.nvim_open_win(buf, false, {
        -- Size
        width = width,
        height = math.min(#lines + 1, 10), -- Limit height to 10 lines

        -- Position
        relative = "editor",
        row = vim.api.nvim_get_option("lines"),
        col = vim.api.nvim_get_option("columns") / 2 - (width / 2), -- Classic way to calc center

        -- Style
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

local persistent_signature_help = function()
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

vim.keymap.set("n", "<leader>h", persistent_signature_help, { desc = "Persistent Signature Help" })
vim.keymap.set("i", "<C-a>", persistent_signature_help, { desc = "Persistent Signature Help" })

local scroll_mode = false

local function toggle_scroll_mode()
  scroll_mode = not scroll_mode

  if scroll_mode then
    -- Enter scroll mode
    vim.keymap.set('n', 'd', '<C-d>', { buffer = true, desc = 'Scroll down half page' })
    vim.keymap.set('n', 'u', '<C-u>', { buffer = true, desc = 'Scroll up half page' })
    vim.keymap.set('n', 'f', '<C-f>', { buffer = true, desc = 'Scroll down full page' })
    vim.keymap.set('n', 'b', '<C-b>', { buffer = true, desc = 'Scroll up full page' })
    vim.keymap.set('n', 'j', '<C-e>', { buffer = true, desc = 'Scroll down one line' })
    vim.keymap.set('n', 'k', '<C-y>', { buffer = true, desc = 'Scroll up one line' })
    print("Scroll mode enabled")
  else
    -- Exit scroll mode (restore normal behavior)
    vim.keymap.del('n', 'd', { buffer = true })
    vim.keymap.del('n', 'u', { buffer = true })
    vim.keymap.del('n', 'f', { buffer = true })
    vim.keymap.del('n', 'b', { buffer = true })
    vim.keymap.del('n', 'j', { buffer = true })
    vim.keymap.del('n', 'k', { buffer = true })
    print("Scroll mode disabled")
  end
end

-- Toggle with <Leader>s
vim.keymap.set('n', '<Leader>m', toggle_scroll_mode, { desc = 'Toggle scroll mode' })

return {
    debug
}
