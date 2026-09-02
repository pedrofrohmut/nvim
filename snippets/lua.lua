local ls = require("luasnip")


return {
    ls.parser.parse_snippet("vkey", "vim.keymap.set"),
    ls.parser.parse_snippet("vcmd", "vim.api.nvim_create_autocmd"),
    ls.parser.parse_snippet("vg", "vim.g."),

     ls.snippet({ trig = "-/" }, ls.function_node(function()
         local cur_col = vim.fn.col(".")
         local n = 80 - cur_col + 1
         if n <= 0 then return "" end
         return string.rep("-", n)
     end, {})),
}
