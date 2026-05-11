local map = vim.keymap.set
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local themes = require("telescope.themes")

require("telescope").setup({
    defaults = {
        file_ignore_patterns = {
            "bin/",
            "obj/",
            "%.o",
            "%.out",
            "node_modules/",
            ".git/",
            "target/",
            "_build",
            ".elixir_ls",
            "deps",
            "%.lock",
            "package-lock.json",
            "dist/",
            ".next",
        },
        mappings = {
            i = {
                ["<C-s>"] = actions.file_split,
                ["<C-v>"] = actions.file_vsplit,
            },
            n = {
                ["<C-s>"] = actions.file_split,
                ["<C-v>"] = actions.file_vsplit,
            },
        },
    },
    pickers = {
        find_files = {
            hidden = true,
        },
        buffers = {
            ignore_current_buffer = true,
            only_cwd = true,
            sort_mru = true,
        },
    },
    extensions = {},
})
require("telescope").load_extension("fzf")

map("n", "<leader>ff", builtin.find_files, { desc = "Telescope Find Files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Telescope Live Grep" })
map("n", "<leader>fb", builtin.buffers, { desc = "Telescope Buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Telescope Help" })
map("n", "<leader>fk", builtin.keymaps, { desc = "Telescope Keymaps" })
map("n", "<leader>fr", builtin.registers, { desc = "Telescope Registers" })

-- Find files with hidden and gitignored
map("n", "<leader>fa", function()
    builtin.find_files({ no_ignore = true, hidden = true })
end, { desc = "Telescope Find Files (no_ignore, no_hidden)" })

local grep_search = function()
    local ok_grep, err = pcall(function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end)

    if not ok_grep and err ~= "Keyboard interrupt" then -- Dont error on Ctrl-C
        error(err)
    end

    vim.cmd.echo("''")
end

map("n", "<leader>fs", grep_search, { desc = "Telescope Grep" })

map("n", "<C-f>", builtin.current_buffer_fuzzy_find, { desc = "Telescope Current Buffer Fuzzy Find" })

local no_preview_dropdown = themes.get_dropdown({
    previewer = false,
    layout_config = { width = 0.55, height = 0.45 },
})

map("n", "<C-q>", function()
    builtin.find_files(no_preview_dropdown)
end, { desc = "Telescope Find Files (No Preview)" })

map("n", "<C-b>", function()
    builtin.buffers(no_preview_dropdown)
end, { desc = "Telescope Buffers (No Preview)" })

map("n", "<leader>fd", builtin.diagnostics, { desc = "Telescope Find Diagnostics" })
map("n", "<leader>fw", builtin.lsp_dynamic_workspace_symbols, { desc = "Telescope Dynamic Workspace Symbols" })
map("n", "<leader>sd", builtin.lsp_document_symbols, { desc = "Telescope Document Symbols" })
map("n", "<leader>sw", builtin.lsp_workspace_symbols, { desc = "Telescope Workspace Symbols" })
