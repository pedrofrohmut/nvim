local oil = require("oil")

local oil_keymaps = {
    -- Default (As a reference)
    -- ["g?"] = "actions.show_help",
    -- ["<CR>"] = "actions.select",
    -- ["<C-s>"] = "actions.select_vsplit",
    -- ["<C-h>"] = "actions.select_split",
    -- ["<C-t>"] = "actions.select_tab",
    -- ["<C-p>"] = "actions.preview",
    -- ["<C-c>"] = "actions.close",
    -- ["<C-l>"] = "actions.refresh",
    -- ["-"] = "actions.parent",
    -- ["_"] = "actions.open_cwd",
    -- ["`"] = "actions.cd",
    -- ["~"] = "actions.tcd",
    -- ["gs"] = "actions.change_sort",
    -- ["gx"] = "actions.open_external",
    -- ["g."] = "actions.toggle_hidden",
    -- ["g\\"] = "actions.toggle_trash",

    -- Custom
    ["g?"] = "actions.show_help",

    ["<CR>"] = "actions.select",
    ["-"] = "actions.parent",
    ["L"] = "actions.select",
    ["H"] = "actions.parent",

    ["<C-v>"] = "actions.select_vsplit",
    ["<C-s>"] = "actions.select_split",
    ["<C-t>"] = "actions.select_tab",

    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["<C-l>"] = "actions.refresh",

    ["g."] = "actions.toggle_hidden",
    ["g\\"] = "actions.toggle_trash",
}

oil.setup({
    default_file_explorer = true, -- Bye bye netrw
    delete_to_trash = true,
    watch_for_changes = true,
    view_options = {
        show_hidden = true,
    },
    use_default_keymaps = false, -- Diasable all predifined keymaps
    keymaps = oil_keymaps,
})

vim.keymap.set("n", "<leader>fo", vim.cmd.Oil)
