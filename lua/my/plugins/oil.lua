local oil = require("oil")

oil.setup({
    default_file_explorer = true, -- Bye bye netrw
    use_default_keymaps = false, -- Diasable all predifined keymaps
    keymaps = {
        -- Default (As a reference)
        --["g?"] = "actions.show_help",
        --["<CR>"] = "actions.select",
        --["<C-s>"] = "actions.select_vsplit",
        --["<C-h>"] = "actions.select_split",
        --["<C-t>"] = "actions.select_tab",
        --["<C-p>"] = "actions.preview",
        --["<C-c>"] = "actions.close",
        --["<C-l>"] = "actions.refresh",
        --["-"] = "actions.parent",
        --["_"] = "actions.open_cwd",
        --["`"] = "actions.cd",
        --["~"] = "actions.tcd",
        --["gs"] = "actions.change_sort",
        --["gx"] = "actions.open_external",
        --["g."] = "actions.toggle_hidden",
        --["g\\"] = "actions.toggle_trash",

        -- Custom
        ["g?"] = "actions.show_help",
        ["H"] = "actions.parent",
        ["L"] = "actions.select",
        ["-"] = "actions.parent",
        ["<CR>"] = "actions.select",
        ["<M-h>"] = "actions.toggle_hidden",
        ["<M-r>"] = "actions.refresh",
        ["<M-q>"] = "actions.close",
        ["gh"] = "actions.open_cwd",
        ["go"] = "actions.preview",
    },
})

vim.keymap.set("n", "<leader>fo", vim.cmd.Oil)
