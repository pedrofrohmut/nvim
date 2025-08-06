require("nvim-treesitter.configs").setup({
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = {
        -- Main required always for neovim
        "c", "lua", "vim", "vimdoc", "query",
        -- Extra my choices
        "java", "c_sharp"
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = false,

    -- To customize the highlight when necessary
    highlight = {
        enable = true,

        -- list of language that will be disabled
        disable = { "javascript", "typescript", "tsx" },
    },

    -- Indentation based on treesitter for the |=| operator.
    indent = { enable = false },
})
