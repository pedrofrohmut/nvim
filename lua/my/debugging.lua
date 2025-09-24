local dap = require("dap")
local dapui = require("dapui")

dapui.setup({
    layouts = {
        {
            elements = {
                {
                    id = "scopes",
                    size = 0.6,
                },
                -- }, {
                --   id = "breakpoints",
                --   size = 0.25
                -- }, {
                --   id = "stacks",
                --   size = 0.25
                -- }, {
                {
                    id = "watches",
                    size = 0.4,
                },
            },
            position = "left",
            size = 0.5,
        },
        {
            elements = {
                {
                    id = "repl",
                    size = 0.5,
                },
                {
                    id = "console",
                    size = 0.5,
                },
            },
            position = "bottom",
            size = 8,
        },
    },
})

-- Dap -------------------------------------------------------------------------

vim.keymap.set("n", "<leader>db", function()
    dap.set_breakpoint()
    print("DEBUG: Breakpoint set")
end)
vim.keymap.set("n", "<leader>dB", function()
    dap.toggle_breakpoint()
    print("DEBUG: Breakpoint toggled")
end)
vim.keymap.set("n", "<leader>dC", function()
    dap.clear_breakpoints()
    print("DEBUG: All the breakpoints have been cleared")
end)
-- vim.keymap.set("n", "<leader>dr", function()
--     dap.run_last()
--     print("DEBUG: Re-running the last debug session")
-- end)
vim.keymap.set("n", "<leader>dr", function()
    dap.restart()
    print("DEBUG: Restarting the current debug session")
end)
vim.keymap.set("n", "<leader>dq", function()
    dap.terminate()
    print("DEBUG: Debug session terminated")
end)

vim.keymap.set("n", "<F5>", function()
    dap.continue()
    vim.api.nvim_feedkeys("zz", "n", false)
end)
vim.keymap.set("n", "<F6>", function()
    dap.step_over()
    vim.api.nvim_feedkeys("zz", "n", false)
end)
vim.keymap.set("n", "<F7>", function()
    dap.step_into()
    vim.api.nvim_feedkeys("zz", "n", false)
end)
vim.keymap.set("n", "<F8>", function()
    dap.step_out()
    vim.api.nvim_feedkeys("zz", "n", false)
end)

-- vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
--     require("dap.ui.widgets").preview()
-- end)
--
-- vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
--     require("dap.ui.widgets").hover()
-- end)

-- Dap UI ----------------------------------------------------------------------

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
-- dap.listeners.before.event_terminated.dapui_config = function()
--     dapui.close()
-- end
-- dap.listeners.before.event_exited.dapui_config = function()
--     dapui.close()
-- end

vim.keymap.set("n", "<leader>dt", require("dapui").toggle)

-- Dap Virtual Text ------------------------------------------------------------

-- require("nvim-dap-virtual-text").setup()

-- C/C++ GDB -------------------------------------------------------------------

dap.adapters.gdb = {
    type = "executable",
    command = "gdb",
    args = { "--interpreter=dap" },
}

local c_cpp_config = {
    {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
    },
}

dap.configurations.c = c_cpp_config
dap.configurations.cpp = c_cpp_config

-- CSharp NetCoreDbg -----------------------------------------------------------

dap.adapters.coreclr = {
    type = "executable",
    command = "netcoredbg",
    args = { "--interpreter=vscode" },
}

dap.configurations.cs = {
    {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
            return vim.fn.input("Path to dll => ", vim.fn.getcwd() .. "", "file")
        end,
    },
    --[[
    The file should be like this:
    ``` debug.lua
    return {
        dll_path = "Hello/bin/Debug/net8.0/Hello.dll",
        project_root = "Hello"
    }
    ```
    The path should be from the vim.cwd to be appended to the vim.fn.getcwd() later
    ]]--
    {
        type = "coreclr",
        name = "launch - debug.lua",
        request = "launch",
        program = function()
            local config_path = vim.fn.getcwd() .. "/debug.lua"

            if vim.fn.filereadable(config_path) ~= 1 then
                vim.notify("No debug.lua found in the vim cwd")
                return nil
            end

            local config = dofile(config_path)

            if config.dll_path == nil then
                vim.notify("No 'dll_path' found in debug.lua")
                return nil
            end

            local full_dll_path = vim.fn.getcwd() .. "/" .. config.dll_path
            vim.notify("Debug started for: " .. full_dll_path)

            return full_dll_path
        end,
        cwd = function()
            local config = dofile(vim.fn.getcwd() .. '/debug.lua')

            if config.project_root == nil then
                vim.notify("No 'project_root' found in debug.lua")
                return nil
            end

            return vim.fn.getcwd() .. "/" .. config.project_root
        end,
    },
}

-- Golang ----------------------------------------------------------------------

dap.adapters.delve = {
    type = "server",
    port = "${port}",
    executable = {
        command = "dlv",
        args = { "dap", "-l", "127.0.0.1:${port}", "--log", "--log-output=dap" },
        detached = vim.fn.has("win32") == 0,
    },
}

dap.configurations.go = {
    {
        type = "delve",
        name = "Debug",
        request = "launch",
        program = "${file}",
    },
    {
        type = "delve",
        name = "Debug test", -- configuration for debugging test files
        request = "launch",
        mode = "test",
        program = "${file}",
    },
    -- works with go.mod packages and sub packages
    {
        type = "delve",
        name = "Debug test (go.mod)",
        request = "launch",
        mode = "test",
        program = "./${relativeFileDirname}",
    },
}
