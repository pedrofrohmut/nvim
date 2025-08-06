local map = vim.keymap.set

-- Config ----------------------------------------------------------------------

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = false,
})

-- Mappings --------------------------------------------------------------------

map("n", "<F11>", function()
    vim.cmd.LspRestart()
    vim.cmd.echo("'Lsp Restarted'")
end)
map("n", "<F12>", vim.cmd.LspInfo, { silent = true })
map("n", "[d", vim.diagnostic.goto_prev, { silent = true })
map("n", "]d", vim.diagnostic.goto_next, { silent = true })
map("n", "<leader>cdo", vim.diagnostic.open_float, { silent = true })
map("n", "<leader>cdl", vim.diagnostic.setloclist, { silent = true })
map("n", "<leader>cdd", vim.diagnostic.disable, { silent = true })
map("n", "<leader>cde", vim.diagnostic.enable, { silent = true })

-- LspAttach -------------------------------------------------------------------

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }

        local telescope = require("telescope.builtin")
        map("n", "gd", telescope.lsp_definitions, opts)
        map("n", "gt", telescope.lsp_type_definitions, opts)
        map("n", "gy", telescope.lsp_implementations, opts)
        map("n", "gR", telescope.lsp_references, opts)

        -- Default vim lsp commands for when telescope does not work
        map("n", "<leader>gd", vim.lsp.buf.definition, opts)
        map("n", "<leader>gt", vim.lsp.buf.type_definition, opts)
        map("n", "<leader>gy", vim.lsp.buf.implementation, opts)
        map("n", "<leader>gr", vim.lsp.buf.references, opts)

        map("n", "gD", vim.lsp.buf.declaration, opts)

        map("n", "K", vim.lsp.buf.hover, opts)
        map("n", "<leader>k", vim.lsp.buf.signature_help, opts)

        map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
        map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
        map("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)

        map("n", "<leader>rn", vim.lsp.buf.rename, opts)

        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        map("n", "<leader>cf", vim.lsp.buf.format, opts)

        -- Get the client from the event
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        -- Attach navic if the client supports document symbols
        local navic = require("nvim-navic")
        if client.server_capabilities.documentSymbolProvider then
            navic.attach(client, ev.buf)
        end
    end,
})
