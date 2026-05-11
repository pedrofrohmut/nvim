local map = vim.keymap.set
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Servers ---------------------------------------------------------------------

vim.lsp.config("lua_ls", {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = {
                    'lua/?.lua',
                    'lua/?/init.lua',
                },
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    vim.api.nvim_get_runtime_file("lua/lspconfig", false)[1],
                },
            },
        }
    },
})
vim.lsp.config("clangd", {})
vim.lsp.config("pyright", {})
vim.lsp.config("ts_ls", {})
vim.lsp.config("omnisharp", {})
vim.lsp.config("gopls", {})
vim.lsp.config("cssls", {})
vim.lsp.config("html", {})
vim.lsp.config("emmet_ls", {})

vim.lsp.config('*', {
    capabilities = capabilities
})

vim.lsp.enable("lua_ls")
vim.lsp.enable("clangd")
vim.lsp.enable("pyright")
vim.lsp.enable("ts_ls")
vim.lsp.enable("omnisharp")
vim.lsp.enable("gopls")
vim.lsp.enable("cssls")
vim.lsp.enable("html")
vim.lsp.enable("emmet_ls")

-- Config ----------------------------------------------------------------------

-- vim.diagnostic.config({
--     virtual_text = false,
--     signs = true,
--     underline = true,
--     update_in_insert = false,
--     severity_sort = false,
-- })

-- Mappings --------------------------------------------------------------------

--[[
  GLOBAL DEFAULTS                       *gra* *gri* *grn* *grr* *grt* *grx* *i_CTRL-S*

  These GLOBAL keymaps are created unconditionally when Nvim starts:

  - "gra" (Normal and Visual mode) is mapped to |vim.lsp.buf.code_action()|
  - "gri" is mapped to |vim.lsp.buf.implementation()|
  - "grn" is mapped to |vim.lsp.buf.rename()|
  - "grr" is mapped to |vim.lsp.buf.references()|
  - "grt" is mapped to |vim.lsp.buf.type_definition()|
  - "grx" is mapped to |vim.lsp.codelens.run()|
  - "gO" is mapped to |vim.lsp.buf.document_symbol()|
  - CTRL-S (Insert mode) is mapped to |vim.lsp.buf.signature_help()|
  - |v_an| and |v_in| fall back to LSP |vim.lsp.buf.selection_range()| if
    treesitter is not active.
  - |gx| handles `textDocument/documentLink`. Example: with gopls, invoking gx
    on "os" in this Go code will open documentation externally: >
      package nvim
      import (
         "os"
      )
]]

-- LSP
map("n", "<F11>", function()
    vim.cmd("lsp restart")
    vim.cmd.echo("'Lsp Restarted'")
end, { desc = "Restart Lsp" })
map("n", "<F12>", function()
    vim.cmd("checkhealth vim.lsp")
end, { silent = true, desc = "Lsp Info" })

-- Diagnostic
map("n", "<leader>dd", function()
    vim.diagnostic.enable(false)
    vim.cmd.echo("'Diagnostics Disabled'")
end, { desc = "Disable Diagnostics" })
map("n", "<leader>de", function()
    vim.diagnostic.enable(true)
    vim.cmd.echo("'Diagnostics Enabled'")
end, { desc = "Enable Diagnostics" })

--  Diagnostic Jumping Prev/Next
map("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go To Previous Diagnostic" })
map("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go To Next Diagnostic" })

-- LspAttach -------------------------------------------------------------------

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    end,
})
