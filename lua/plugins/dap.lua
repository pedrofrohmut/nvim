local dap = require("dap")
local dapui = require("dapui")

dapui.setup({
    layouts = {
        {
            elements = {
                { id = "scopes", size = 0.65 },
                { id = "watches", size = 0.35 },
            },
            position = "left",
            size = 0.4,
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
map("n", "<leader>dx", function()
    if my_confirm("Disconnect the debug session?") then
        dap.disconnect()
        print("Debug session Disconnected")
    end
end, { desc = "Debug: Disconnect" })
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

dap.adapters.gdb_attach = {
    type = "executable",
    command = "gdb",
    args = { "--interpreter=dap", "--eval-command", "target remote localhost:9222" },
}

local c_cpp_config = {
    {
        name = "Launch GDB",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
    },
    --[[
    The file should be like this:
    ``` debug.lua
    return {
        executable_path = "./my_app",
    }
    ```
    The path should be from the vim.cwd to be appended to the vim.fn.getcwd() later
    ]]
    {
        name = "Launch GDB - debug.lua",
        type = "gdb",
        request = "launch",
        program = function()
            local config_path = vim.fn.getcwd() .. "/debug.lua"

            if vim.fn.filereadable(config_path) ~= 1 then
                vim.notify("No debug.lua found in the vim cwd")
                return nil
            end

            local config = dofile(config_path)

            if config.executable_path == nil then
                vim.notify("No 'executable_path' found in debug.lua")
                return nil
            end

            local full_exe_path = vim.fn.getcwd() .. "/" .. config.executable_path

            if vim.fn.filereadable(full_exe_path) ~= 1 then
                vim.notify("Could not found the executable at '" .. full_exe_path .. "'")
                return nil
            end

            vim.notify("Debug is starting for: " .. full_exe_path)

            return full_exe_path
        end,
        cwd = "${workspaceFolder}",
    },
    -- TODO: Change this one to gdb_attach
    -- {
    --     name = "Launch Winedbg - debug.lua",
    --     type = "winedbg",
    --     request = "launch",
    --     program = function()
    --         local config_path = vim.fn.getcwd() .. "/debug.lua"
    --
    --         if vim.fn.filereadable(config_path) ~= 1 then
    --             vim.notify("No debug.lua found in the vim cwd")
    --             return nil
    --         end
    --
    --         local config = dofile(config_path)
    --
    --         if config.executable_path == nil then
    --             vim.notify("No 'executable_path' found in debug.lua")
    --             return nil
    --         end
    --
    --         local full_exe_path = vim.fn.getcwd() .. "/" .. config.executable_path
    --
    --         if vim.fn.filereadable(full_exe_path) ~= 1 then
    --             vim.notify("Could not found the executable at '" .. full_exe_path .. "'")
    --             return nil
    --         end
    --
    --         vim.notify("Debug is starting for: " .. full_exe_path)
    --
    --         return full_exe_path
    --     end,
    --     cwd = "${workspaceFolder}",
    -- }
}

dap.configurations.c = c_cpp_config
dap.configurations.cpp = c_cpp_config

-- CSharp NetCoreDbg -----------------------------------------------------------

dap.adapters.netcoredbg = {
    type = "executable",
    command = "netcoredbg",
    args = { "--interpreter=vscode" },
}

dap.configurations.cs = {
    {
        type = "netcoredbg",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
            return vim.fn.input("Path to dll => ", vim.fn.getcwd() .. "", "file")
        end,
        cwd = "${workspaceFolder}",
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
        type = "netcoredbg",
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

-- JavaScript/Typescript -------------------------------------------------------

dap.adapters["pwa-chrome"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
        command = "js-debug-adapter",
        args = { "${port}" },
    },
}

dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
        command = "js-debug-adapter",
        args = { "${port}" },
    },
}

dap.configurations.javascript = {
    {
        name = "Launch Chrome",
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
        port = 9229,
        webRoot = "${workspaceFolder}",
    },
    {
        name = "Launch Node",
        type = "pwa-node",
        request = "launch",
        program = "${file}",
        cwd = "${workspaceFolder}",
    },
    {
        name = "Attach Node",
        type = "pwa-node",
        request = "attach",
        address = "localhost",
        port = 9229,
        cwd = "${workspaceFolder}",
        restart = true, -- Try to reconnect if lose connection
    },
}

dap.configurations.typescript = {
    {
        name = "Launch TS-Node",
        type = "pwa-node",
        request = "launch",
        program = "${file}",
        cwd = "${workspaceFolder}",
        runtimeExecutable = "npx",
        runtimeArgs = { "ts-node" },
        sourceMaps = true,
        protocol = "inspector",
        skipFiles = { "<node_internals>/**", "node_modules/**" },
        resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
        },
    },
    {
        name = "Attach TS-Node",
        type = "pwa-node",
        request = "attach",
        address = "localhost",
        port = 9229,
        cwd = "${workspaceFolder}",
        sourceMaps = true,
        skipFiles = { "<node_internals>/**", "node_modules/**" },
        resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
        },
        restart = true,
    },
    {
        name = "Launch TSX",
        type = "pwa-node",
        request = "launch",
        program = "${file}",
        cwd = "${workspaceFolder}",
        runtimeExecutable = "npx",
        runtimeArgs = { "tsx" },
        sourceMaps = true,
        protocol = "inspector",
        skipFiles = { "<node_internals>/**", "node_modules/**" },
        resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
        },
    },
    {
        name = "Attach TSX",
        type = "pwa-node",
        request = "attach",
        address = "localhost",
        port = 9229,
        cwd = "${workspaceFolder}",
        sourceMaps = true,
        skipFiles = { "<node_internals>/**", "node_modules/**" },
        resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
        },
        restart = true,
    },
}

-- dap.configurations.typescript = dap.configurations.javascript
-- dap.configurations.javascriptreact = dap.configurations.javascript
-- dap.configurations.typescriptreact = dap.configurations.javascript
