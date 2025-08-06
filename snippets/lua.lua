local ls = require("luasnip")

return {
    ls.parser.parse_snippet("vkey", "vim.keymap.set"),
    ls.parser.parse_snippet("vcmd", "vim.api.nvim_create_autocmd"),
    ls.parser.parse_snippet("vg", "vim.g."),
}
