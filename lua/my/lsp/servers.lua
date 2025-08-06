local default_capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Servers ---------------------------------------------------------------------

-- Link to consult on configurations
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

-- C / C++
require("lspconfig").clangd.setup({ capabilities = default_capabilities })

-- CSS
require("lspconfig").cssls.setup({ capabilities = default_capabilities })

-- HTML
require("lspconfig").html.setup({ capabilities = default_capabilities })

-- Emmet
-- require("lspconfig").emmet_ls.setup({ capabilities = default_capabilities })
-- require("lspconfig").emmet_language_server.setup({ capabilities = default_capabilities })

-- Vuejs
-- require("lspconfig").volar.setup({ capabilities = default_capabilities })

-- Lua/Lua_LS
require("lspconfig").lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim", "use" },
            },
        },
    },
    capabilities = default_capabilities,
})

-- Python
require("lspconfig").pyright.setup({ capabilities = default_capabilities })

-- Typescript
require("lspconfig").ts_ls.setup({ capabilities = default_capabilities })

-- EXTRA SERVERS ###############################################################

-- CSharp/Omnisharp
require("lspconfig").omnisharp.setup({
    -- cmd = { "dotnet", "/home/pedro/opt/omnisharp/OmniSharp.dll" }, -- From ref link above
    -- cmd = { "/home/pedro/opt/omnisharp/OmniSharp", "-lsp" },
    capabilities = default_capabilities,
})
-- TODO: Config csharp with: Omnisharp-Extended-Lsp. at: https://github.com/Hoffs/omnisharp-extended-lsp.nvim

-- Go with gopls
require("lspconfig").gopls.setup({ capabilities = default_capabilities })

-- Java
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "java" },
    callback = function()
        require("jdtls").start_or_attach({
            cmd = { vim.fn.expand("$HOME/.local/share/nvim/mason/bin/jdtls") },
            root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
            capabilities = default_capabilities,
            settings = {
                java = {
                    format = {
                        settings = {
                            profile = "GoogleStyle", -- Or "Eclipse" or any custom profile
                        },
                    },
                },
            },
        })

        local options = { noremap = true, silent = true }
        vim.api.nvim_buf_set_keymap(0, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", options)
        vim.api.nvim_buf_set_keymap(0, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", options)
        vim.api.nvim_buf_set_keymap(0, "n", "gy", "<cmd>lua vim.lsp.buf.implementation()<CR>", options)
        vim.api.nvim_buf_set_keymap(0, "n", "gr", '<cmd>lua vim.lsp.buf.references() && vim.cmd("copen")<CR>', options)

        vim.api.nvim_buf_set_keymap(0, "n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", options)

        vim.api.nvim_buf_set_keymap(0, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", options)
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>k", "<cmd>lua vim.lsp.buf.signature_help()<CR>", options)

        vim.api.nvim_buf_set_keymap(0, "n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", options)
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", options)
        vim.api.nvim_buf_set_keymap(
            0,
            "n",
            "<leader>wl",
            "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
            options
        )

        vim.api.nvim_buf_set_keymap(0, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", options)

        vim.api.nvim_buf_set_keymap(0, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", options)

        vim.api.nvim_buf_set_keymap(0, "n", "<leader>cf", "<cmd>lua vim.lsp.buf.format()<CR>", options)

        -- vim.api.nvim_buf_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
        -- vim.api.nvim_buf_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')

        -- -- Java specific
        -- vim.api.nvim_buf_keymap("n", "<leader>di", "<Cmd>lua require'jdtls'.organize_imports()<CR>")
        -- vim.api.nvim_buf_keymap("n", "<leader>dt", "<Cmd>lua require'jdtls'.test_class()<CR>")
        -- vim.api.nvim_buf_keymap("n", "<leader>dn", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>")
        -- vim.api.nvim_buf_keymap("v", "<leader>de", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>")
        -- vim.api.nvim_buf_keymap("n", "<leader>de", "<Cmd>lua require('jdtls').extract_variable()<CR>")
        -- vim.api.nvim_buf_keymap("v", "<leader>dm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>")
    end,
})

-- require("lspconfig").jdtls.setup({
--     -- root_dir = function()
--     --     return vim.fn.getcwd()
--     -- end,
--     -- root_dir = function()
--     --     local cwd = vim.fn.getcwd()
--     --     if vim.fn.filereadable(cwd .. "/pom.xml") == 1 then
--     --         return cwd
--     --     else
--     --         vim.notify("Error: pom.xml not found in the current working directory: " .. cwd, vim.log.levels.ERROR)
--     --         return nil -- Or handle the case where pom.xml is not found in cwd
--     --     end
--     -- end,
--     capabilities = capabilities,
-- })
-- root_dir = require'lspconfig'.util.root_pattern("./pom.xml"),
-- root_dir = function() vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]) end,
