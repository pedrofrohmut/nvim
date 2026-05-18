local dap = require("dap")
local dapui = require("dapui")

dapui.setup({
    layouts = {
        {
            elements = {
                { id = "scopes", size = 0.6 },
                { id = "watches", size = 0.4 },
            },
            position = "left",
            size = 0.5,
        },
        {
            elements = {
                { id = "repl", size = 0.5 },
                { id = "console", size = 0.5 },
            },
            position = "bottom",
            size = 10,
        },
    },
    -- mappings = {
    --   edit = "e",
    --   expand = { "<CR>", "<2-LeftMouse>" },
    --   open = "o",
    --   remove = "d",
    --   repl = "r",
    --   toggle = "t"
    -- },
})

local map = vim.keymap.set
local user_cmd = vim.api.nvim_create_user_command

local my_confirm = function(text)
    return vim.fn.confirm(text, "&Yes\n&No", 5)
end

-- Start / Restart / Stop
map("n", "<F5>", function()
    if dap.session() == nil then
        print("Debug Session Starting...")
    end
    dap.continue()
end, { desc = "Debug: Start/Continue" })
map("n", "<leader>dt", function()
    if my_confirm("Terminate the debug session?") then
        dap.terminate()
        print("Debug Session Terminated")
    end
end, { desc = "Debug: Terminate" })
map("n", "<leader>dr", function()
    if my_confirm("Restart debug session?") then
        dap.restart()
        print("Debug Session Restarted")
    end
end, { desc = "Debug: Restart Debug Session" })

-- Stepping
map("n", "<F10>", function()
    dap.step_over()
    vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = "Debug: Step Over" })
map("n", "<F11>", function()
    dap.step_into()
    vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = "Debug: Step Into" })
map("n", "<S-F11>", function()
    dap.step_out()
    vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = "Debug: Step Out" })

-- Breakpoints
map("n", "<F9>", function()
    dap.toggle_breakpoint()
    print("Breakpoint toggled")
end, { desc = "Debug: Toggle Breakpoint" })
map("n", "<leader>dC", function()
    if my_confirm("Clear All The Breakpoints?") == 1 then
        dap.clear_breakpoints()
        print("Breakpoints all cleared.")
    else
        print("Canceled. Breakpoints are kept.")
    end
end, { desc = "Debug: Toggle Breakpoint" })

-- User Commands ---------------------------------------------------------------

user_cmd("Debug", dap.continue, { desc = "Debug: Starts the debugger" })
user_cmd("DebugRestart", dap.restart, { desc = "Debug: Restart" })
user_cmd("DebugTerminate", dap.terminate, { desc = "Debug: Restart" })

-- Dap UI ----------------------------------------------------------------------

-- Hide/show ui with listeners
dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end

map("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggles the UI" })

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
    ]]
    --
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
            local config = dofile(vim.fn.getcwd() .. "/debug.lua")

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

-- JavaScript ------------------------------------------------------------------

dap.adapters["pwa-chrome"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
        command = "js-debug-adapter",
        args = { "${port}" },
    },
}

dap.adapters["node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
        command = "js-debug-adapter",
        args = { "${port}" },
    },
}
dap.adapters["pwa-node"] = dap.adapters["node"]

dap.configurations.javascript = {
    {
        name = "Launch Chrome Localhost",
        type = "pwa-chrome",
        request = "launch",
        url = "http://localhost:3000",
        webRoot = "${workspaceFolder}",
        sourceMaps = true,
    },
    {
        name = "Attach to Chrome",
        type = "pwa-chrome",
        request = "attach",
        port = 9222,
        webRoot = "${workspaceFolder}",
    },
    {
        name = "Launch Node.js",
        type = "pwa-node", -- Use pwa-node for JavaScript/TypeScript
        request = "launch",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
        },
        runtimeExecutable = "node",
        skipFiles = { "<node_internals>/**" },
    },
}

dap.configurations.typescript = dap.configurations.javascript
dap.configurations.javascriptreact = dap.configurations.javascript
dap.configurations.typescriptreact = dap.configurations.javascript
