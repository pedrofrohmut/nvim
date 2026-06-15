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
            { name = "nvim_lsp_signature_help" },
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

local buffer_completion = {
    config = {
        sources = cmp.config.sources({
            { name = "buffer" },
        }),
    },
}

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
        ["<Enter>"] = cmp.mapping(function(fallback)
            if not cmp.visible() then
                fallback()
            else
                cmp.confirm({ select = true })
            end
        end),
        ["<C-e>"] = cmp.mapping.abort(),

        -- LSP
        ["<C-j>"] = cmp.mapping(function()
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

        -- AI Minuet
        -- ["<C-x>i"] = require("minuet").make_cmp_map(),

        -- Buffer
        ["<C-p>"] = cmp.mapping(function()
            if not cmp.visible() then
                cmp.complete(buffer_completion)
            else
                cmp.select_prev_item()
            end
        end),
        ["<C-n>"] = cmp.mapping(function()
            if not cmp.visible() then
                cmp.complete(buffer_completion)
            else
                cmp.select_next_item()
            end
        end),

        -- Snippets
        ["<A-s>"] = cmp.mapping(function()
            if luasnip.expand_or_jumpable() then
                print("Expanding....")
                if not luasnip.expand_or_jump() then
                    print("Fail to expand or jump lua snip")
                end
            else
                print("Not a snippet")
            end
        end),
        -- ["<A-s>"] = cmp.mapping(function()
        --     if not cmp.visible() then
        --         cmp.complete(snip_completion)
        --     end
        -- end),
        ["<A-n>"] = cmp.mapping(function()
            local forward = 1
            if luasnip.jumpable(forward) then
                luasnip.jump(forward)
            else
                vim.notify("No snippets available to jump to", vim.log.levels.WARN)
            end
        end, { "i", "s" }),
        ["<A-p>"] = cmp.mapping(function()
            local backward = -1
            if luasnip.jumpable(backward) then
                luasnip.jump(backward)
            else
                vim.notify("No snippets available to jump to", vim.log.levels.WARN)
            end
        end, { "i", "s" }),
    }),
})

cmp.setup.cmdline("/", {
    -- completion = {
    --     autocomplete = { 'TextChanged', 'InsertEnter' },
    -- },
    mapping = cmp.mapping.preset.cmdline(), -- Manual trigger <C-i>
    sources = {
        { name = "buffer" },
    },
})

cmp.setup.cmdline(":", {
    -- completion = {
    --     autocomplete = { "TextChanged", "InsertEnter" },
    -- },
    mapping = cmp.mapping.preset.cmdline(), -- Manual trigger <C-i>
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        {
            name = "cmdline",
            option = {
                ignore_cmds = { "Man", "!" },
            },
        },
    }),
})
