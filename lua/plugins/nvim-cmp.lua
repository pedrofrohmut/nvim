local cmp = require("cmp")
local luasnip = require("luasnip")

-- This is here to work with Friendly Snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- Custome Snippets with LuaSnips
-- how-to: make all.lua for global snips and rust.lua for rust snips
require("luasnip.loaders.from_lua").lazy_load({
    paths = "~/.config/nvim/snippets/",
})

local lsp_completion = {
    config = {
        sources = cmp.config.sources({
            { name = 'nvim_lsp_signature_help' },
            { name = "nvim_lsp" },
        }),
    },
}

local path_completion = {
    config = {
        sources = cmp.config.sources({ { name = "path" } }),
    },
}

local snip_completion = {
    config = {
        sources = cmp.config.sources({ { name = "luasnip" } }),
    },
}

-- local ai_completion = {
--     config = {
--         sources = cmp.config.sources({ { name = "codeium" } }),
--     },
-- }

cmp.setup({
    completion = {
        autocomplete = false,
    },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },

    mapping = cmp.mapping.preset.insert({
        -- Docs scrolling
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),

        -- Accept and abort completions
        ["<Enter>"] = cmp.mapping.confirm({ select = true }),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-Space>"] = cmp.mapping(function()
            if not cmp.visible() then
                cmp.complete(lsp_completion)
            else
                cmp.confirm({ select = true })
            end
        end),

        -- File path
        ["<C-f>"] = cmp.mapping(function()
            if not cmp.visible() then
                cmp.complete(path_completion)
            end
        end),

        -- AI (Cannot use <C-i> because tmux)
        -- ["<C-k>"] = cmp.mapping(function()
        --     if not cmp.visible() then
        --         cmp.complete(ai_completion)
        --     else
        --         cmp.abort()
        --     end
        -- end),

        -- Snippets
        ["<C-k>"] = cmp.mapping(function()
            if not cmp.visible() then
                cmp.complete(snip_completion)
            end
        end),
        ["<A-n>"] = cmp.mapping(function()
            local forward = 1
            if luasnip.jumpable(forward) then
                luasnip.jump(forward)
            else
                vim.notify("No snippets available to jump to", vim.log.levels.WARN)
            end
        end),
        ["<A-p>"] = cmp.mapping(function()
            local backward = -1
            if luasnip.jumpable(backward) then
                luasnip.jump(backward)
            else
                vim.notify("No snippets available to jump to", vim.log.levels.WARN)
            end
        end),
    }),
    sources = cmp.config.sources({
        { name = "buffer" },
        -- { name = "nvim_lsp" },
        -- { name = "luasnip" },
    }),
})

-- `/` cmdline setup.
cmp.setup.cmdline('/', {
    -- completion = {
    --     autocomplete = { 'TextChanged', 'InsertEnter' },
    -- },
    mapping = cmp.mapping.preset.cmdline(), -- Manual trigger <C-i>
    sources = {
        { name = 'buffer' }
    }
})

-- `:` cmdline setup.
cmp.setup.cmdline(':', {
    -- completion = {
    --     autocomplete = { 'TextChanged', 'InsertEnter' },
    -- },
    mapping = cmp.mapping.preset.cmdline(), -- Manual trigger <C-i>
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        {
            name = 'cmdline',
            option = {
                ignore_cmds = { 'Man', '!' }
            }
        }
    })
})
