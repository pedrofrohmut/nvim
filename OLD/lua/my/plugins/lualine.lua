require("lualine").setup {
    options = {
        component_separators = { left = "|", right = "|" },
    },
    sections = {
        -- Left side a, b, c
        lualine_a = {},
        lualine_b = {
            {
                "filename",
                file_status = true,
                newfile_status = false,
                path = 1,
                shorting_target = 40,
                symbols = {
                    modified = "[+]",
                    readonly = "[-]",
                    unnamed = "[No Name]",
                    newfile = "[New]",
                }
            }
        },
        lualine_c = {},
        --lualine_c = {
        --    function()
        --        ---@diagnostic disable-next-line: unused-local
        --        local ok, _err =  pcall(require, "lsp_signature")
        --        if not ok then
        --            return "no signature"
        --        end
        --        local signature = require("lsp_signature").status_line(100)
        --        -- return sign.label .. " HELLO " .. sign.hint
        --        if signature.label ~= "" then
        --            return signature.label
        --        else
        --            return ""
        --        end
        --    end
        --},

        -- Right Side x, y, z
        lualine_x = {
            "filetype",
            {
                "fileformat",
                symbols = { unix = "UNIX", dos = "DOS", mac = "MAC" }
            },
            "encoding"
        },
        lualine_y = { "progress", "location" },
        lualine_z = {}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
            {
                "filename",
                file_status = true,
                newfile_status = false,
                path = 1,
                shorting_target = 40,
                symbols = {
                    modified = "[+]",
                    readonly = "[-]",
                    unnamed = "[No Name]",
                    newfile = "[New]",
                }
            }
        },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {}
    },
}
