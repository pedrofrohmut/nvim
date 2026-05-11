-- Help: windsurf

require("codeium").setup({
    workspace_root = {
        use_lsp = false,
        find_root = function()
            vim.fn.getcwd()
        end,
    },
    enable_cmp_source = true,
    virtual_text = {
        enabled = true,
        manual = true,
        map_keys = true,
        key_bindings = {
            -- Accept the current completion.
            accept = "<A-m>",
            -- Accept the next word.
            accept_word = false,
            -- Accept the next line.
            accept_line = "<A-y>",
            -- Clear the virtual text.
            clear = false,
            -- Cycle to the next completion.
            next = "<A-]>",
            -- Cycle to the previous completion.
            prev = "<A-[>",
        },
    },
})

vim.keymap.set("i", "<A-i>", require("codeium.virtual_text").cycle_or_complete)
